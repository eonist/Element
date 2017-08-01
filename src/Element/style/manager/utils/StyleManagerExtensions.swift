import Cocoa
@testable import Utils

/*Parser*/
extension StyleManager{
    /**
     * Locates and returns a Style by the PARAM: name.
     * RETURN: a Style
     */
    static func getStyle(_ name:String)->IStyle?{
        return self.styles.first(where:{$0.name == name})
    }
    static func getStyle(_ index:Int)->IStyle?{
        return styles[safe:index]//<-⚠️️ just added safe
    }
    /**
     * New
     */
    static func getStylePropVal(_ styleName:String, _ stylePropertyName:String, _ depth:Int = 0) -> Any?{
        return StyleManager.getStyle(styleName)?.getStyleProperty(stylePropertyName)?.value
    }
    /**
     * New
     */
    static func index(_ name:String) -> Int?{
        return styles.index(where: {$0.name == name})
    }
}
/*Modifier*/
extension StyleManager{
    /**
     * Adds a style to the styleManager class
     * PARAM: style: IStyle
     */
    static func addStyle(_ style:IStyle){
        styles.append(style)
    }
    /**
     * Removes the first style that has PARAM: name
     */
    static func removeStyle(_ name:String) -> IStyle? {
        if let i:Int = styles.index(where: {$0.name == name}){
            return styles.splice2(i,1)[0]
        }
        return nil
    }
    /**
     * Removes styles
     */
    static func removeStyle(_ styles:[IStyle]){
        _ = styles.map{removeStyle($0.name)}
    }
    /**
     * Adds every style in a styleCollection to the stylemanager
     */
    static func addStyle(_ styles:[IStyle]){
        if isHashingStyles {
            styles.lazy.filter{$0.selectors.count > 0}.forEach{StyleManagerUtils.hashStyle($0)}
        }
        self.styles += styles
    }
    /**
     * Adds styles by parsing PARAM string (the string must comply to the Element CSS syntax)
     * TODO: ⚠️️ add support for CSS import statement in the PARAM: string
     */
    static func addStyle(_ cssString:String){
        let resolvedLinksCSS = CSSLinkResolver.resolveLinks(cssString)
        let removedCommentsCSS = RegExpModifier.removeComments(resolvedLinksCSS)
        let styles = CSSParser.styleCollection(removedCommentsCSS).styles
        addStyle(styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * PARAM: liveEdit enables you to see css changes while an app is running
     * IMPORTANT: ⚠️️ LiveEdit only removes styles that are updated, and then adds these new styles. (It's a simple approach)
     * NOTE: to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     * TODO: ⚠️️ Implement support for subFile watching aka watch children files that are imported into a parent css file
     * TODO: ⚠️️ Implement running the css resolve process on a background thread
     */
    static func addStylesByURL(_ url:String,_ liveEdit:Bool = false) {
        if(liveEdit){
            let cssString:String = CSSFileParser.cssString(url)
            if(cssFiles[url] != nil){/*check if the url already exists in the dictionary*/
                let cssString:String = CSSLinkResolver.resolveLinks(cssFiles[url]!)
                let styles:[IStyle] = CSSParser.styleCollection(cssString).styles
                removeStyle(styles)/*if url exists then remove the styles that it represents*/
            }else{/*If the url wasn't in the dictionary, then add it*/
                cssFiles[url] = cssString//<--I'm not sure how this works, but it works
            }
            addStyle(cssString)
        }else{/*not live*/
            /*1. Assert if the styles.xml exists and if it has content*/
            let theUrl:String  = FilePathParser.resourcePath() + "/temp.bundle/styles/styles.xml"//"~/Desktop/styles.xml".tildePath
            
            let stylesXMLExists:Bool = FileAsserter.exists(theUrl)
            Swift.print("xmlExists: " + "\(stylesXMLExists)")
            
            //TODO: ⚠️️ Create a new styles.xml if non exists
            
            
            let xml:XML = FileParser.xml(theUrl)//this should not be hardwired like this. use resource files or alike
            let cssFileDateList = StyleCache.cssFileDateList(xml)
            /*2. assert if the query url has been cached and assert if the cached css files are all up to date*/
            let hasURLBeenCached:Bool = StyleCache.hasFileBeenCached(cssFileDateList, url)
            Swift.print("hasURLBeenCached: " + "\(hasURLBeenCached ? "✅" : "🚫")")
            let isUpToDate = StyleCache.isUpToDate(cssFileDateList)
            Swift.print("isUpToDate: " + "\(isUpToDate ?  "✅" : "🚫" )")
            /*if true then: read the styles from the xml*/
            if(hasURLBeenCached && isUpToDate){
                StyleCache.readStylesFromXML(xml)/*Super fast loading of cached styles*/
            }else{/*Else read and parse styles from the .css files and write a new cache to styles.xml*/
                let startTime = NSDate()
                let cssString:String = CSSFileParser.cssString(url)/*This takes a few secs, basic.css takes around 4sec*/
                addStyle(cssString)
                Swift.print("Adding css styles time: " + "\(abs(startTime.timeIntervalSinceNow))")
                StyleCache.writeStylesToDisk()
            }
        }
    }
    /**
     * New
     */
    static func overrideStylePropertyValue(_ styleName:String, _ stylePropertyName:String, _ newValue:Any, _ depth:Int = 0){
        if  let i = StyleManager.index(styleName),
            let style:IStyle = StyleManager.styles[safe:i],
            let e:Int = StyleParser.idx(style, stylePropertyName) {
                StyleManager.styles[i].styleProperties[e].value = newValue
        }
    }
    /**
     * New
     */
    static func overrideStyle(_ style:Style){
        if let i:Int = StyleManager.index(style.name) {
            StyleManager.styles[i] = style
        }
    }
    /**
     * New
     */
    static func reset(){
        StyleManager.styles = []/*Reset*/
        StyleResolver.cachedStyles = [:]//Reset the cache aswell
    }
}

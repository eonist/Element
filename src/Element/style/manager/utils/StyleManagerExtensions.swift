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
    static func addStyle(_ styles:[IStyle], isHasingStyles:Bool = StyleManager.isHashingStyles){
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
        addStyle(StyleManagerUtils.styles(from: cssString))
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * PARAM: liveEdit enables you to see css changes while an app is running
     * IMPORTANT: ⚠️️ LiveEdit only removes styles that are updated, and then adds these new styles. (It's a simple approach)
     * NOTE: to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     * TODO: ⚠️️ Implement running the css resolve process on a background thread
     */
    static func addStyle(url stylesURL:String,liveEdit:Bool = false) {
        if liveEdit {/*liveEdit, don't read from cache*/
            let cssString:String = CSSFileParser.cssString(stylesURL)
            let styles:[IStyle] = {
                if let cssFile = cssFiles[stylesURL]{/*check if the url already exists in the dictionary*/
                    let cssString:String = CSSLinkResolver.resolveLinks(cssFile)
                    let styles:[IStyle] = StyleManagerUtils.styles(from: cssString)//was CSSParser.styleCollection(cssString).styles
                    removeStyle(styles)/*if url exists then remove the styles that it represents*/
                    return styles
                }else{/*If the url wasn't in the dictionary, then add it*/
                    cssFiles[stylesURL] = cssString//<--I'm not sure how this works, but it works
                    return StyleManagerUtils.styles(from: cssString)
                }
            }()
            addStyle(styles)
        }else{/*not live, try and read from cache*/
            let styles = StyleCache.styles(stylesURL: stylesURL)
            addStyle(styles)
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
//DEPRECATED
extension StyleManager{
    static func addStylesByURL(_ url:String,_ liveEdit:Bool = false) {//legacy support
        addStyle(url:url,liveEdit:liveEdit)
    }
}

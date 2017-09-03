import Cocoa
@testable import Utils

/*Modifier*/
extension StyleManager{
    /**
     * Adds a style to the styleManager class
     * PARAM: style: IStyle
     */
    static func addStyle(_ style:Stylable){
        styles.append(style)
    }
    /**
     * Removes the first style that has PARAM: name
     */
    static func removeStyle(_ name:String) -> Stylable? {
        if let i:Int = styles.index(where: {$0.name == name}){
            return styles.splice2(i,1)[0]
        }
        return nil
    }
    /**
     * Removes styles
     */
    static func removeStyle(_ styles:[Stylable]){
        _ = styles.map{removeStyle($0.name)}
    }
    /**
     * Adds every style in a styleCollection to the stylemanager
     */
    static func addStyle(_ styles:[Stylable], isHasingStyles:Bool = StyleManager.isHashingStyles){
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
        let styles = StyleManagerUtils.styles(cssString)
        addStyle(styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * PARAM: liveEdit enables you to see css changes while an app is running
     * PARAM: stylesURL: full path: (/User/James/Desktop/styles/test.css)
     * IMPORTANT: ⚠️️ LiveEdit only removes styles that are updated, and then adds these new styles. (It's a simple approach)
     * NOTE: to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     * TODO: ⚠️️ Implement running the css resolve process on a background thread
     */
    static func addStyle(url stylesURL:String,liveEdit:Bool = false) {
        let styles:[Stylable] = {
            if liveEdit { return LiveEdit.styles(stylesURL) }/*liveEdit, don't read from cache*/
            //
            let fileName:String = FilePathParser.fileName(path:stylesURL,withExtension:false)//last part of the url
            let cacheURL:String = StyleManager.cacheBaseURL + fileName + ".xml"//We need an unique URL because multiple styles caches can be created, this facilitates fast switching of themes
            Swift.print("cacheURL: " + "\(cacheURL)")
            
            //Continue here 🏀
                //Figure out why xml isnt considered cached or uptodate
                //Figure out why UI components wont let their skin be re applied. Try a button, then a Text then a textField
            
            
            return StyleCache.styles(stylesURL:stylesURL,cacheURL:cacheURL) ?? Utils.readStylesFromCSSFiles(stylesURL:stylesURL,cacheURL:cacheURL)/*not live, try and read from cache*/
        }()
        addStyle(styles)
    }
    /**
     * New
     */
    static func overrideStylePropertyValue(_ styleName:String, _ stylePropertyName:String, _ newValue:Any, _ depth:Int = 0){
        if  let i = StyleManager.index(styleName),
            let style:Stylable = StyleManager.styles[safe:i],
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
private class Utils{
    /**
     * Read and parse styles from the .css files and write a new cache to styles.xml
     */
    static func readStylesFromCSSFiles(stylesURL:String,cacheURL:String) -> [Stylable] {
        let styles:[Stylable] = testPerformance ("Adding css styles time: "){/*performance test*/
            let cssString:String = CSSFileParser.cssString(stylesURL)/*This takes a few secs, basic.css takes around 4sec*/
            return StyleManagerUtils.styles(cssString,removeComments:false)/*<--we already removed comments so no need to do it again*/
        }
        StyleCache.save(styles,to:cacheURL)
        return styles
    }
}



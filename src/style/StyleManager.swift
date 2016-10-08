import Foundation
/**
 * NOTE: The reason we use array instead of object: a problem may be that the order will be different every time you read this object, random
 * EXAMPLE: print("StyleManager.getInstance().getStyle(Button): " + StyleManager.getInstance().getStyle("someText").getPropertyNames());//prints style names
 * // :TODO:  Could potentially extend StyleCollection and just implimnet the extra functions in this class?!?
 * // :TODO: This class can be a struct
 * TODO: the tail trick could possibly be even faster if you sorted the hashed styles and used a halfed algo when querrying (but its a dictionary so maybe not, maybe if you stored it in an array etc)
 */
class StyleManager{
    static var cssFiles:Dictionary<String,String> = [:]
    static var cssFileURLS:[String] = []//<--new
    static var styles:Array<IStyle> = []
    static var isHashingStyles:Bool = true/*enable this if you want to hash the styles (beta)*/
    /**
     * Adds a style to the styleManager class
     * @param style: IStyle
     */
    static func addStyle(style:IStyle){
        styles.append(style)
    }
    /**
     *
     */
    static func removeStyle(name:String) -> IStyle? {
        let numOfStyles:Int = styles.count;
        for (var i : Int = 0; i < numOfStyles; i++){if(styles[i].name == name) {return styles.splice2(i,1)[0]}}
        return nil
    }
    /**
     * Locates and returns a Style by the @param name.
     * @return a Style
     */
    static func getStyle(name:String)->IStyle?{
        let numOfStyles:Int = styles.count;
        for(var i:Int = 0;i < numOfStyles;i++) {if((styles[i] as IStyle).name == name) {return styles[i]}}
        return nil
    }
}
//convenince methods
extension StyleManager{
    /**
     * Adds every style in a styleCollection to the stylemanager
     */
    static func addStyle(styles:Array<IStyle>){
        if(isHashingStyles){styles.forEach{StyleManagerUtils.hashStyle($0)}}
        self.styles += styles/*<- concats*/
    }
    /**
     * Removes styles
     */
    static func removeStyle(styles:Array<IStyle>){
        for style in styles{removeStyle(style.name)}
    }
    /**
     * Adds styles by parsing @param string (the string must comply to the Element css syntax)
     * // :TODO: add support for css import statement in the @param string
     */
    static func addStyle(var cssString:String){
        cssString = CSSLinkResolver.resolveLinks(cssString)
        cssString = RegExpModifier.removeComments(cssString)
        addStyle(CSSParser.styleCollection(cssString).styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * PARAM: liveEdit enables you to see css changes while an app is running
     * IMPORTANT: LiveEdit only removes styles that are updated, and then adds these new styles. (It's a simple aporch)
     * NOTE: to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     */
    static func addStylesByURL(url:String,_ liveEdit:Bool = false) {
        let cssString:String = CSSFileParser.cssString(url)
        if(liveEdit){
            if(cssFiles[url] != nil){/*check if the url already exists in the dictionary*/
                let cssString:String = CSSLinkResolver.resolveLinks(cssFiles[url]!)
                let styles:[IStyle] = CSSParser.styleCollection(cssString).styles
                removeStyle(styles)/*if url exists then remove the styles that it represents*/
            }else{/*if the url wasn't in the dictionary, then add it*/
                cssFiles[url] = cssString//<--im not sure how this works, but it works
            }
        }
        
        //1. assert if the styles.xml exists and if it has content 
        let stylesXMLExists:Bool = FileAsserter.exists("~/Desktop/styles.xml".tildePath)
        Swift.print("stylesXMLExists: " + "\(stylesXMLExists)")
        let stylesXML:XML = FileParser.xml("~/Desktop/styles.xml".tildePath)
        let cssFileDateList = StyleCache.cssFileDateList(stylesXML)
        //2. assert if the query url has been cached and assert if the cached css files are all up to date
        let hasBeenCached:Bool = StyleCache.hasFileBeenCached(cssFileDateList, url)
        //if true then: read the styles from the xml
        //else read and parse styles from the .css files and write a new cache to styles.xml
        //3. continue
        
        addStyle(cssString)
    }
    static func getStyleAt(index:Int)->IStyle{
        return styles[index]
    }
}

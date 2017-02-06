import Foundation
@testable import Utils
/**
 * NOTE: The reason we use array instead of object: a problem may be that the order will be different every time you read this object, random
 * EXAMPLE: print("StyleManager.getInstance().getStyle(Button): " + StyleManager.getInstance().getStyle("someText").getPropertyNames());//prints style names
 * TODO:  Could potentially extend StyleCollection and just implimnet the extra functions in this class?!?
 * TODO: This class can be a struct
 * TODO: the tail trick could possibly be even faster if you sorted the hashed styles and used a halfed algo when querrying (but its a dictionary so maybe not, maybe if you stored it in an array etc)
 */
class StyleManager{
    static var cssFiles:Dictionary<String,String> = [:]
    static var cssFileURLS:[String] = []//<--new
    static var styles:Array<IStyle> = []
    static var isHashingStyles:Bool = true/*enable this if you want to hash the styles (beta)*/
    /**
     * Adds a style to the styleManager class
     * PARAM: style: IStyle
     */
    static func addStyle(_ style:IStyle){
        styles.append(style)
    }
    /**
     * TODO: This method could probably be a candidate for functional programming: .map or .flatMap etc etc
     */
    static func removeStyle(_ name:String) -> IStyle? {
        for i in 0..<styles.count{//upgraded to swift 3 support
            if(styles[i].name == name) {
                return styles.splice2(i,1)[0]
            }
        }
        return nil
    }
    /**
     * Locates and returns a Style by the @param name.
     * RETURN: a Style
     */
    static func getStyle(_ name:String)->IStyle?{
        for (_,style) in self.styles.enumerated(){//<--forEach was not used because it doesn't allow return
            if(style.name == name) {return style}
        }
        return nil
    }
}
//convenince methods
extension StyleManager{
    /**
     * Adds every style in a styleCollection to the stylemanager
     */
    static func addStyle(_ styles:Array<IStyle>){
        if(isHashingStyles){
            styles.forEach{
                //swift 3 update, now checks .count > 0
                if($0.selectors.count > 0){StyleManagerUtils.hashStyle($0)}
            }
        }
        self.styles += styles/*<- concats*/
    }
    /**
     * Removes styles
     */
    static func removeStyle(_ styles:Array<IStyle>){
        for style in styles{
            _ = removeStyle(style.name)
        }
    }
    /**
     * Adds styles by parsing PARAM string (the string must comply to the Element CSS syntax)
     * // :TODO: add support for CSS import statement in the @param string
     */
    static func addStyle(_ cssString:String){
        var cssString = cssString//swift 3 update
        cssString = CSSLinkResolver.resolveLinks(cssString)
        cssString = RegExpModifier.removeComments(cssString)
        addStyle(CSSParser.styleCollection(cssString).styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * PARAM: liveEdit enables you to see css changes while an app is running
     * IMPORTANT: LiveEdit only removes styles that are updated, and then adds these new styles. (It's a simple approach)
     * NOTE: to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     * TODO: Implement support for subFile watching aka watch children files that are imported into a parent css file
     * TODO: Implement running the css resolve process on a background thread
     */
    static func addStylesByURL(_ url:String,_ liveEdit:Bool = false) {
        if(liveEdit){
            let cssString:String = CSSFileParser.cssString(url)
            if(cssFiles[url] != nil){/*check if the url already exists in the dictionary*/
                let cssString:String = CSSLinkResolver.resolveLinks(cssFiles[url]!)
                let styles:[IStyle] = CSSParser.styleCollection(cssString).styles
                removeStyle(styles)/*if url exists then remove the styles that it represents*/
            }else{/*if the url wasn't in the dictionary, then add it*/
                cssFiles[url] = cssString//<--I'm not sure how this works, but it works
            }
            addStyle(cssString)
        }else{/*not live*/
            /*1. assert if the styles.xml exists and if it has content*/
            let stylesXMLExists:Bool = FileAsserter.exists("~/Desktop/styles.xml".tildePath)
            Swift.print("xmlExists: " + "\(stylesXMLExists)")
            let xml:XML = FileParser.xml("~/Desktop/styles.xml".tildePath)//this should not be hardwired like this. use resource files or alike
            let cssFileDateList = StyleCache.cssFileDateList(xml)
            /*2. assert if the query url has been cached and assert if the cached css files are all up to date*/
            let hasURLBeenCached:Bool = StyleCache.hasFileBeenCached(cssFileDateList, url)
            Swift.print("hasURLBeenCached: " + "\(hasURLBeenCached)")
            let isUpToDate = StyleCache.isUpToDate(cssFileDateList)
            Swift.print("isUpToDate: " + "\(isUpToDate)")
            /*if true then: read the styles from the xml*/
            if(hasURLBeenCached && isUpToDate){
                StyleCache.readStylesFromDisk(xml)/*Super fast loading of cached styles*/
            }else{/*else read and parse styles from the .css files and write a new cache to styles.xml*/
                let startTime = NSDate()
                let cssString:String = CSSFileParser.cssString(url)/*This takes a few secs, basic.css takes around 4sec*/
                addStyle(cssString)
                Swift.print("Adding css styles time: " + "\(abs(startTime.timeIntervalSinceNow))")
                StyleCache.writeStylesToDisk()
            }
        }
    }
    static func getStyleAt(_ index:Int)->IStyle{
        return styles[index]
    }
}

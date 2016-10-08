import Foundation
/**
 * NOTE: The reason we use array instead of object: a problem may be that the order will be different every time you read this object, random
 * EXAMPLE: print("StyleManager.getInstance().getStyle(Button): " + StyleManager.getInstance().getStyle("someText").getPropertyNames());//prints style names
 * // :TODO:  Could potentially extend StyleCollection and just implimnet the extra functions in this class?!?
 * // :TODO: This class can be a struct
 */
class StyleManager{
    static var cssFiles:Dictionary<String,String> = [:]
    static var styles:Array<IStyle> = []
    static var styleTree:[String:Any] = [:]
    static var isHashingStyles:Bool = true/*enable this if you want to hash the styles (beta)*/
    /**
     * Adds @param styles to @param styleTree
     */
    static func addStyle(inout styleTree:[String:Any],_ styles:[IStyle]) -> [String:Any]{
        for  style : IStyle in styles{ addStyle(style,&styleTree)}
        return styleTree
    }
    /**
     * Adds @param style as a branch to @param parentBranch
     */
    static func addStyle(style:IStyle, inout _ parentBranch:[String:Any], _ cursor:Int = 0){
        //print("branch.cursor: " + "\(cursor)")
        if(cursor < style.selectors.count) {
            let selectorString:String = SelectorParser.selectorString(style.selectors[cursor])/*creates a string representation of the selector*/
            //print("selectorString: " + "\(selectorString)")
            if(parentBranch[selectorString] == nil) {
                //print("no branch with key: " + "\(selectorString)" + " was found, create new branch and append")
                var newBranch:[String:Any] = [:]
                addStyle(style, &newBranch, cursor+1)
                parentBranch[selectorString] = newBranch
            }else{
                //print("the branch with key: "+ "\(selectorString)" +" exist, append ")
                var existingBranch:[String:Any] = parentBranch[selectorString] as! [String:Any]
                addStyle(style, &existingBranch, cursor+1)
                parentBranch[selectorString] = existingBranch
            }
        }else{
            //print("append branch with style")
            parentBranch["style"] = style
        }
    }
    
    /**
     * Adds a style to the styleManager class
     * @param style: IStyle
     */
    class func addStyle(style:IStyle){
        styles.append(style)
    }
    /**
     *
     */
    class func removeStyle(name:String) -> IStyle? {
        let numOfStyles:Int = styles.count;
        for (var i : Int = 0; i < numOfStyles; i++){if(styles[i].name == name) {return styles.splice2(i,1)[0]}}
        return nil
    }
    /**
     * Locates and returns a Style by the @param name.
     * @return a Style
     */
    class func getStyle(name:String)->IStyle?{
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
    class func addStyle(styles:Array<IStyle>){
        if(isHashingStyles){styles.forEach{StyleManagerUtils.hashStyle($0)}}
        self.styles += styles/*<- concats*/
    }
    /**
     * Removes styles
     */
    class func removeStyle(styles:Array<IStyle>){
        for style in styles{removeStyle(style.name)}
    }
    /**
     * Adds styles by parsing @param string (the string must comply to the Element css syntax)
     * // :TODO: add support for css import statement in the @param string
     */
    class func addStyle(var cssString:String){
        cssString = CSSLinkResolver.resolveLinks(cssString)
        cssString = RegExpModifier.removeComments(cssString)
        addStyle(/*&styleTree,*/CSSParser.styleCollection(cssString).styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * @Note to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     */
    class func addStylesByURL(url:String,_ liveEdit:Bool = false) {
        let cssString:String = CSSFileParser.cssString(url)
        if(liveEdit){
            if(cssFiles[url] != nil){/*check if the url already exists in the dictionary*/
                let cssString:String = CSSLinkResolver.resolveLinks(cssFiles[url]!)
                let styles:[IStyle] = CSSParser.styleCollection(cssString).styles
                removeStyle(styles)/*if url exists it does then remove the styles that it represents*/
            }else{/*if the url wasn't in the dictionary, then add it*/
                cssFiles[url] = cssString
            }
        }
        addStyle(cssString)
    }
    class func getStyleAt(index:Int)->IStyle{
        return styles[index]
    }
}

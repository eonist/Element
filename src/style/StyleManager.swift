import Foundation
/**
 * TODO: This class can be a struct
 */
class StyleManager{
    static var styles:Array<IStyle> = []
    /**
     * Adds a style to the styleManager class
     * @param style: IStyle
     */
    class func addStyle(style:IStyle){
        styles.append(style)
    }
    public function removeStyle(name:String):IStyle {
    var numOfStyles:int = _styles.length;
    for (var i : int = 0; i < numOfStyles; i++) if(IStyle(_styles[i]).name == name) return _styles.splice (i,1);
    return null;
    }
    /**
     * Locates and returns a Style by the @param name.
     * @return a Style
     */
    class func getStyle(name:String)->IStyle?{
        let numOfStyles:Int = styles.count;
        for(var i:Int = 0;i < numOfStyles;i++) {
            if((styles[i] as IStyle).name == name) {
                return styles[i]
            }
        }
        return nil
    }
}
//convenince methods
extension StyleManager{
    /**
     * Adds every style in a styleCollection to the stylemanager
     */
    class func addStyle(styles:Array<IStyle>){
        self.styles += styles/*<- concats*/
    }
    /**
     * Adds styles by parsing @param string (the string must comply to the Element css syntax)
     * // :TODO: add support for css import statement in the @param string
     */
    class func addStyle(var cssString:String){
        cssString = CSSLinkResolver.resolveLinks(cssString)
        cssString = RegExpModifier.removeComments(cssString)
        addStyle(CSSParser.styleCollection(cssString).styles)
    }
    /**
     * Adds styles by parsing a .css file (the css file can have import statements which recursivly are also parsed)
     * @Note to access files within the project bin folder use: File.applicationDirectory.url + "assets/temp/main.css" as the url
     */
    class func addStylesByURL(url:String) {
        let cssString:String = CSSFileParser.cssString(url)
        addStyle(cssString)
    }
}
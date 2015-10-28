import Foundation
class StyleModifier {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * // :TODO: explain what newSelectors does
     */
    class func clone(style:IStyle, _ newName:String? = nil)->IStyle{
        let returnStyle:IStyle = Style(newName ?? style.name);
        for styleProperty : IStyleProperty in style.styleProperties{
            returnStyle.addStyleProperty(StyleProperty(styleProperty.name, styleProperty.value));
        }
        return returnStyle;
    }
    /**
    *
    */
    class func overrideStyleProperty(inout style:IStyle, _ styleProperty:IStyleProperty){// :TODO: argument should only be a styleProperty
        let stylePropertiesLength:Int = style.styleProperties.count;
        for (var i:Int=0; i<stylePropertiesLength; i++) { // :TODO: use fore each
            if((style.styleProperties[i] as IStyleProperty).name == styleProperty.name){
                style.styleProperties[i] = styleProperty;
                break//was return
            }
        }
        Swift.print("\(String(style))"+" PROPERTY BY THE NAME OF "+styleProperty.name+" WAS NOT FOUND IN THE PROPERTIES ")//this should throw error
    }
    
    /**
    * Combines @param a and @param b
    * @Note: if similar styleProperties are found @param b takes precedence
    */
    class func combine(a:IStyle,b:IStyle){
        for stylePropA : IStyleProperty in a.styleProperties {
            for stylePropB : IStyleProperty in b.styleProperties {
                if(stylePropA.name == stylePropB.name){
                    
                }
            }
        }
    }
}


import Foundation
class StyleModifier {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * TODO: explain what newSelectors does
     */
    static func clone(style:IStyle, _ newName:String? = nil, _ newSelectors:Array<ISelector>? = nil)->IStyle{
        let returnStyle:IStyle = Style(newName ?? style.name, newSelectors ?? style.selectors,[])
        for styleProperty:IStyleProperty in style.styleProperties{
            returnStyle.addStyleProperty(StyleProperty(styleProperty.name, styleProperty.value, styleProperty.depth))
        }
        return returnStyle
    }
    /**
     *
     */
    static func overrideStyleProperty(inout style:IStyle, _ styleProperty:IStyleProperty){// :TODO: argument should only be a styleProperty
        for i in 0..<style.styleProperties.count{/*<--we can't use for each here because it needs to break*/
            if(style.styleProperties[i].name == styleProperty.name){
                style.styleProperties[i] = styleProperty
                break//was return
            }
        }
        //Swift.print("\(String(style))"+" PROPERTY BY THE NAME OF "+styleProperty.name+" WAS NOT FOUND IN THE PROPERTIES ")//this should throw error
    }
    /**
     * Combines PARAM: a and PARAM: b
     * NOTE: if similar styleProperties are found PARAM: b takes precedence
     * TODO: you can speed this method up by looping with a  better algo. dont check already checked b's etc
     * TODO: maybe use map or filter to speed this up?
     */
    static func combine(inout a:IStyle,_ b:IStyle){
        //Swift.print("combining initiated")
        for i in 0..<b.styleProperties.count{
            let stylePropB:IStyleProperty = b.styleProperties[i]
            let matchIndex = Utils.matchAt(a, stylePropB)
            if(matchIndex != -1){/*Asserts true if styleProperty exist in both styles*/
                a.styleProperties[matchIndex] = stylePropB/*styleProperty already exist so overide it*/
            }else{
                StyleModifier.append(&a,stylePropB)/*Doesn't exist so just add the style prop*/
            }
        }
    }
    /**
     * Merges PARAM: a with PARAM: b (does not override, but only prepends styleProperties that are not present in style PARAM: a)
     * NOTE: the prepend method is used because the styleProps that has priority should come later in the array)
     * TODO: you can speed up this method by looping with a  better algo. don't check already checked b's etc
     * TODO: maybe use map or filter to speed this up?
     */
    static func merge(inout a:IStyle,_ b:IStyle){
        /*Swift.print("-----start---")
        StyleParser.describe(a)
        Swift.print("--------")
        StyleParser.describe(b)
        Swift.print("----end----")*/
        for stylePropB:IStyleProperty in b.styleProperties {
            var hasStyleProperty:Bool = false
            for stylePropA:IStyleProperty in a.styleProperties {
                if(stylePropB.name == stylePropA.name && stylePropB.depth == stylePropA.depth){
                    hasStyleProperty = true
                    break/*breaks out of the loop*/
                }
            }
            if(!hasStyleProperty) {//asserts true if the style from b doest exist in a
                StyleModifier.prepend(&a, stylePropB)/*a.addStyleProperty(stylePropB)*/;/*only prepends the styleProperty if it doesnt already exist in the style instance a*/
            }
        }
    }
    /**
     * Returns PARAM: style that has its styleProperties filtered by PARAM: filter (removed any styleProperty by a name that is not in the filter array)
     * NOTE: this method works faster than ArrayModifier.removeTheseByKey
     */
    static func filter(style:IStyle,_ filter:Array<String>)->IStyle {
        var styleProperties:Array<IStyleProperty> = []
        for i in 0..<style.styleProperties.count{//<--swift 3 support
            if(ArrayParser.index(filter,(style.styleProperties[i] as IStyleProperty).name) != -1) {styleProperties.append(style.styleProperties[i])}/*we only keep items that are in both arrays*/
        }
        return Style(style.name,style.selectors,styleProperties)
    }
    /**
     * Adds PARAM: styleProperty to the end of the PARAM: style.styleProperties array
     * NOTE: Will throw an error if a styleProperty with the same name is allready added
     * TODO: Add a checkFlag, sometimes the cecking of existance is already done by the caller
     */
    static func append(inout style:IStyle,_ styleProperty:IStyleProperty){
        //Swift.print("append happended")
        for styleProp:IStyleProperty in style.styleProperties{
            if(styleProp.name == styleProperty.name && styleProp.depth == styleProperty.depth) {
                fatalError(String(style) + " STYLE PROPERTY BY THE NAME OF " + styleProperty.name + " IS ALREADY IN THE _styleProperties ARRAY: " + styleProperty.name)/*checks if there is no duplicates in the list*/
            }
        }
        style.styleProperties.append(styleProperty)
    }
    /**
     * Adds PARAM: styleProperty to the start of the PARAM: style.styleProperties array
     * TODO: add a checkFlag, sometimes the cecking of existance is already done by the caller
     */
    static func prepend(inout style:IStyle,_ styleProperty:IStyleProperty){
        //Swift.print("prepend happended: styleProperty: " + styleProperty.name)
        for styleProp:IStyleProperty in style.styleProperties{
            if(styleProp.name == styleProperty.name && styleProp.depth == styleProperty.depth) {
                fatalError(String(style) + " STYLE PROPERTY BY THE NAME OF " + styleProperty.name + " IS ALREADY IN THE _styleProperties ARRAY: " + styleProperty.name)/*checks if there is no duplicates in the list*/
            }
        }
        ArrayModifier.unshift(&style.styleProperties, styleProperty)
    }
}
private class Utils{
    static func matchAt(style:IStyle, _ styleProperty:IStyleProperty)->Int{
        for i in 0..<style.styleProperties.count{
            let styleProp:IStyleProperty = style.styleProperties[i]
            if(styleProperty.name == styleProp.name){
                return i
            }
        }
        return -1
    }
}
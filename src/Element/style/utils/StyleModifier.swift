import Foundation
@testable import Utils

class StyleModifier {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * TODO: explain what newSelectors does
     */
    static func clone(_ style:IStyle, _ newName:String? = nil, _ newSelectors:[ISelector]? = nil)->IStyle{
        return Style(newName ?? style.name, newSelectors ?? style.selectors,style.styleProperties.map{$0})//maybe the clone part is not needed?
    }
    /**
     * Overrides styleProperty if one exists with the same name
     * IMPORTANT: ⚠️️ You apperantly have to use Style, protocols are not mutable apperantly
     */
    static func overrideStyleProperty(_ style:inout Style, _ styleProp:IStyleProperty){// :TODO: argument should only be a styleProperty
        if let idx = style.styleProperties.index(where:{$0.name == styleProp.name && $0.depth == styleProp.depth}){
            style.styleProperties[idx] = styleProp
        }
    }
    /**
     *
     */
    static func overrideStylePropVal(_ style:inout Style, stylePropName:String, stylePropDepth:Int, value:Any){
        var style:Style = btn.skin!.style! as! Style
        var widthProp = style.getStyleProperty("width")
        widthProp!.value = newSize.w
        StyleModifier.overrideStyleProperty(&style, widthProp!)
        var heightProp = style.getStyleProperty("height")
        heightProp!.value = newSize.h
        StyleModifier.overrideStyleProperty(&style, heightProp!)
    }
    /**
     * Combines PARAM: a and PARAM: b
     * NOTE: if similar styleProperties are found PARAM: b takes precedence
     * TODO: ⚠️️ You can speed this method up by looping with a  better algo. dont check already checked b's etc
     * TODO: ⚠️️ Maybe use map or filter to speed this up?
     */
    static func combine(_ a:inout IStyle,_ b:IStyle){
        b.styleProperties.forEach{ stylePropB in
            if let matchIndex:Int = a.styleProperties.index(where: {$0.name == stylePropB.name}){/*Asserts true if styleProperty exist in both styles*/
                a.styleProperties[matchIndex] = stylePropB/*styleProperty already exist so overide it*/
            }else{
                StyleModifier.append(&a,stylePropB)/*Doesn't exist so just add the style prop*/
            }
        }
    }
    private static var mergeCondition:(IStyleProperty,IStyleProperty) -> Bool = {$0.name == $1.name && $0.depth == $1.depth}
    /**
     * Merges PARAM: a with PARAM: b (does not override, but only prepends styleProperties that are not present in style PARAM: a)
     * NOTE: the prepend method is used because the styleProps that has priority should come later in the array)
     * TODO: ⚠️️ You can speed up this method by looping with a  better algo. don't check already checked b's etc
     * TODO: ⚠️️ Maybe use map or filter to speed this up?
     */
    static func merge(_ a:inout IStyle,_ b:IStyle){
        b.styleProperties.forEach { stylePropB in
            let hasMatch:Bool = a.styleProperties.first(stylePropB, mergeCondition) != nil
            if(!hasMatch){//asserts true if the style from b doest exist in a
                StyleModifier.prepend(&a, stylePropB)/*a.addStyleProperty(stylePropB) only prepends the styleProperty if it doesnt already exist in the style instance a*/
            }
        }
    }
    /**
     * Returns PARAM: style that has its styleProperties filtered by PARAM: filter (removed any styleProperty by a name that is not in the filter array)
     * NOTE: this method works faster than ArrayModifier.removeTheseByKey
     */
    static func filter(_ style:IStyle,_ filter:[String])->IStyle {
        let styleProperties:[IStyleProperty] = style.styleProperties.filter(){ styleProperty in
            filter.first(where: {styleProperty.name == $0}) != nil/*we only keep items that are in both arrays*/
        }
        return Style(style.name,style.selectors,styleProperties)
    }
    /**
     * Adds PARAM: styleProperty to the end of the PARAM: style.styleProperties array
     * NOTE: Will throw an error if a styleProperty with the same name is allready added
     * TODO: Add a checkFlag, sometimes the cecking of existance is already done by the caller
     */
    static func append(_ style:inout IStyle,_ styleProperty:IStyleProperty){
        if StyleAsserter.alreadyExists(style, styleProperty){
            fatalError("\(style) STYLE PROPERTY BY THE NAME OF " + styleProperty.name + " IS ALREADY IN THE _styleProperties ARRAY: " + styleProperty.name)/*checks if there is no duplicates in the list*/
        }
        style.styleProperties.append(styleProperty)
    }
    /**
     * Adds PARAM: styleProperty to the start of the PARAM: style.styleProperties array
     * TODO: add a checkFlag, sometimes the cecking of existance is already done by the caller
     */
    static func prepend(_ style:inout IStyle,_ styleProperty:IStyleProperty){
        if StyleAsserter.alreadyExists(style, styleProperty) {
            fatalError("\(style) STYLE PROPERTY BY THE NAME OF " + styleProperty.name + " IS ALREADY IN THE _styleProperties ARRAY: " + styleProperty.name)/*checks if there is no duplicates in the list*/
        }
        _ = ArrayModifier.unshift(&style.styleProperties, styleProperty)
    }
}

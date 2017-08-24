import Foundation
@testable import Utils

class StyleResolver{
    //static var isStoringSelectors:Bool = false/*This variable is for optimization debugging and can be deleted or commented out later*/
    static var selectorsString:String = ""/*This variable is for optimization debugging and can be deleted or commented out later*/
    static var styleLookUpCount:Int = 0/*This variable is for optimization debugging and can be deleted or commented out later*/
    static var cachedStyles:[String:Stylable] = [:]
    /**
     * Returns a style comprised of all the styleProperties element inherit from
     * NOTE: Creates a list with styles in the styleManger the styles with highest priority goes to the top, then each consequtive style in this priority list is merged into the first one (if a styleProperty exists it is not overriden, all others are added), styles in the stylemanager that has nothing to do with the current cascade are not included in the priorityList
     * TODO: Should only inherit when property is marked inherit or from * universal selectors!?!?
     */
    static func style(_ element:ElementKind)->Stylable{
        let querySelectors:[SelectorKind] = ElementParser.selectors(element)/*Array instance comprised of Selector instances for each (element,classId,id and state) in the element*/
        //if isStoringSelectors {Debug.appendQuerySelectors(querySelectors)}
        let styleName:String = SelectorParser.string(querySelectors)/*returns the absolute selecter address of the element*/
        if let cachedStyle:Stylable = cachedStyles[styleName]{//new caching feature, was added so that FastTreeList would be smooth. also makes everything else smooth 🎉
            return cachedStyle
        }else{
            let style:Stylable = StyleResolver.style(querySelectors,styleName,element)
            cachedStyles[styleName] = style
            return style
        }
    }
    /**
     * NOTE: Parsing 192 elements with Basic styles with The tail trick: 0.00551801919937134 and w/o: 0.156262040138245 thats a 30x time difference, which is important when you parse lots of items and lots of styles
     * NOTE: style-lookup for BasicWin: 24148 vs 8134 when using the "tail trick"
     */
    static func style(_ querySelectors:[SelectorKind], _ styleName:String, _ element:ElementKind?)->Stylable{
        let styles = StyleManager.styles
        let weightedStyles:[WeightedStyle] = styles.lazy.map { style -> WeightedStyle? in /*This loop disregards styles that don't apply to the element Selectors*/
            if style.selectors.count > querySelectors.count{/*if there are more selectors in style.selectors than in cascade the final styleWeight.weight is 0 and there for it is not included in the weightedStyles array*/
                return nil
            }else{
                let selectorWeights:[SelectorWeight]? = SelectorParser.selectorWeights(style,querySelectors)
                return selectorWeights != nil ? WeightedStyle(style, StyleWeight(selectorWeights!)) : nil
            }
        }.flatMap{$0}.sorted(by: WeightedStyleAsserter.priority) /*Sorts each weightedStyle by its weight, the styles with most specificity has a lower index*/
        var finalStyle:Stylable = StyleManager.getStyle(styleName) ?? Style(styleName,querySelectors,[])/*find the exact styleName in the stylemanager or if that doesn't exist then create a new style to merge partily matched styles*/
        weightedStyles.forEach{ weightStyle in /*compiles the finalStyle by making sure the last selector matches the last selector in the weightstyle, this works different for font etc. which are inheritable*/
            StyleModifier.merge(&finalStyle, StyleAsserter.direct(querySelectors, weightStyle) ? weightStyle : StyleModifier.filter(weightStyle, CSS.Text.textPropertyNames))/*direct styles will be appart of the final style and  you inherit from indirect styles, fonts,*or properties marked inherit*/
        }
        return finalStyle
    }
}
private class Utils{
    /**
     * Helper method for parsing styles by comparing the tail of a style
     */
    static func getStyles(_ selector:SelectorKind)->[Stylable]{
        var styles:[Stylable] = []
        if selector.element != "", let stylesByElement = StyleManagerUtils.stylesByElement[selector.element]{
            styles += stylesByElement
        }
        if selector.id != "", let stylesByID = StyleManagerUtils.stylesByID[selector.id] {
            styles += stylesByID
        }
        if selector.classIds.count > 0, let stylesByClassId = StyleManagerUtils.stylesByClassId[selector.classIds.first!]{
            styles += stylesByClassId
        }
        if selector.states.count > 0, let stylesByState = StyleManagerUtils.stylesByState[selector.states.first!] {
            styles += stylesByState
        }
        return styles
    }
}
private class Debug {
    static func appendQuerySelectors(_ querySelectors:[SelectorKind] ) {
        var selectorsXMLString:String = ""
        querySelectors.forEach{selectorsXMLString += Reflect.toXML($0).string}//you need to collect all selectors in one string, and then after the app has initialized, you need to save this string to disk
        StyleResolver.selectorsString += "<Selectors>" + selectorsXMLString + "</Selectors>"
    }
}


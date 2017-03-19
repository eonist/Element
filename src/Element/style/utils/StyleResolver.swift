import Foundation
@testable import Utils

class StyleResolver{
    static var isStoringSelectors:Bool = false/*This variable is for optimization debugging and can be deleted or commented out later*/
    static var selectorsString:String = ""/*This variable is for optimization debugging and can be deleted or commented out later*/
    static var styleLookUpCount:Int = 0/*This variable is for optimization debugging and can be deleted or commented out later*/
    /**
     * Returns a style comprised of all the styleProperties element inherit from
     * NOTE: Creates a list with styles in the styleManger the styles with highest priority goes to the top, then each consequtive style in this priority list is merged into the first one (if a styleProperty exists it is not overriden, all others are added), styles in the stylemanager that has nothing to do with the current cascade are not included in the priorityList
     * TODO: Should only inherit when property is marked inherit or from * universal selectors!?!?
     */
    static func style(_ element:IElement)->IStyle{
        let querySelectors:[ISelector] = ElementParser.selectors(element)/*Array instance comprised of Selector instances for each (element,classId,id and state) in the element*/
        if(isStoringSelectors){
            var selectorsXMLString:String = ""
            querySelectors.forEach{selectorsXMLString += Reflection.toXML($0).string}//you need to collect all selectors in one string, and then after the app has initialized, you need to save this string to disk
            StyleResolver.selectorsString += "<Selectors>" + selectorsXMLString + "</Selectors>"
        }
        return style(querySelectors,element)
    }
    /**
     * NOTE: Parsing 192 elements with Basic styles with The tail trick: 0.00551801919937134 and w/o: 0.156262040138245 thats a 30x time difference, which is important when you parse lots of items and lots of styles
     * NOTE: style-lookup for BasicWin: 24148 vs 8134 when using the "tail trick"
     */
    static func style(_ querySelectors:[ISelector],_ element:IElement?)->IStyle{
        var weightedStyles:[WeightedStyle] = []
        let styles = StyleManager.styles
        //let styles:[IStyle] = element as? Text != nil ? StyleManager.styles : Utils.getStyles(querySelectors.last!)//<-this is the tail trick
        for style:IStyle in styles {/*This loop disregards styles that don't apply to the element Selectors*/
            //styleLookUpCount++
            if(style.selectors.count > querySelectors.count) {continue;}/*if there are more selectors in style.selectors than in cascade the final styleWeight.weight is 0 and there for it is not included in the weightedStyles array*/
            //Swift.print("style: " + style.name)
            let selectorWeights:[SelectorWeight]? = SelectorParser.selectorWeights(style,querySelectors)
            if(selectorWeights != nil) {weightedStyles.append(WeightedStyle(style, StyleWeight(selectorWeights!)))}
        }
        //Swift.print("weightedStyles: " + weightedStyles.count)
        if(weightedStyles.count > 1) {
            weightedStyles = ArrayParser.conditionSort(weightedStyles, WeightedStyleAsserter.priority)/*Sorts each weightedStyle by its weight, the styles with most specificity has a lower index*/
        }
        let styleName:String = SelectorParser.string(querySelectors)/*returns the absolute selecter address of the element*/
        var finalStyle:IStyle = StyleManager.getStyle(styleName) ?? Style(styleName,querySelectors,[])/*find the exact styleName in the stylemanager or if that doesn't exist then create a new style to merge partily matched styles*/
        
        for weightStyle:WeightedStyle in weightedStyles{/*compiles the finalStyle by making sure the last selector matches the last selector in the weightstyle, this works different for font etc. which are inheritable*/
            StyleModifier.merge(&finalStyle, StyleAsserter.direct(querySelectors, weightStyle) ? weightStyle : StyleModifier.filter(weightStyle, CSSConstants.textPropertyNames))/*direct styles will be appart of the final style and  you inherit from indirect styles, fonts,*or properties marked inherit*/
        }
        return finalStyle
    }
    static func style2(_ element:IElement)->IStyle{
        fatalError("beta")
        /*
        let querySelectors:Array<ISelector> = ElementParser.selectors(element)/*Array instance comprised of Selector instances for each (element,classId,id and state) in the element*/
        return style2(querySelectors)
        */
    }
    static func style2(_ querySelectors:[ISelector])->IStyle{
        fatalError("beta")
        /*
        var weightedStyles:Array<WeightedStyle> = StyleResolverUtils.query(querySelectors,StyleManager.styleTree,0)
        //print("weightedStyles: " + "\(weightedStyles.count)")
        //if(StyleResolver.stackString(element) == "Window Box#tabBarBox SelectTextButton#first Text") for each (var ws : WeightedStyle in weightedStyles) trace("not.Sorted.ws.name: " + ws.name);
        if(weightedStyles.count > 1) {weightedStyles = ArrayParser.conditionSort(weightedStyles, WeightedStyleAsserter.priority)}//WeightStyleParser.sortByWeight(weightedStyles);/*Sorts each weightedStyle by its weight, the styles with most specificity has a lower index*/
        //if(StyleResolver.stackString(element) == "Window Box#tabBarBox SelectTextButton#first Text") for each (var wStyle : WeightedStyle in weightedStyles) trace("sorted.ws.name: " + wStyle.name);
        let styleName:String = SelectorParser.selectorsString(querySelectors)
        var finalStyle:IStyle = StyleManager.getStyle(styleName) ?? Style(styleName,querySelectors,[]);/*find the exact styleName in the stylemanager or create a new style to merge partily matched styles*/
        for weightStyle:WeightedStyle in weightedStyles{
            StyleModifier.merge(&finalStyle, StyleAsserter.direct(querySelectors, weightStyle) ? weightStyle : StyleModifier.filter(weightStyle, CSSConstants.textPropertyNames))/*direct styles will be appart of the final style and  you inherit from indirect styles, fonts,*or properties marked inherit*/
        }
        return finalStyle
        */
    }
}
private class Utils{
    /**
     * Helper method for parsing styles by comparing the tail of a style
     */
    static func getStyles(_ selector:ISelector)->[IStyle]{
        var styles:[IStyle] = []
        if(selector.element != ""){
            if let stylesByElement = StyleManagerUtils.stylesByElement[selector.element]{
                styles += stylesByElement
            }
        }
        if(selector.id != ""){
            if let stylesByID = StyleManagerUtils.stylesByID[selector.id]{
                styles += stylesByID
            }
        }
        if(selector.classIds.count > 0){
            if let stylesByClassId = StyleManagerUtils.stylesByClassId[selector.classIds.first!]{
                styles += stylesByClassId
            }
        }
        if(selector.states.count > 0){
            if let stylesByState = StyleManagerUtils.stylesByState[selector.states.first!]{
                styles += stylesByState
            }
        }
        return styles
    }
}

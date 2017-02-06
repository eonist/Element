import Foundation
@testable import Utils
/**
 * NOTE: We could move this into an internal utils class of StyleResolver but since Selector class is a public class we might aswell keep this class as a public class aswell
 */
class SelectorParser{
    static var cursor:Int = 0//TODO: temp solution, must be fixed, eigther by Creating a class that can hold the cursor, test this first, or by creatin ga method within a method and then reffing cursor
    /**
     * Returns a weight value based on where aSelector is locaeted on the PARAM: b array (higher values means higher priotiy)
     * PARAM: style: originally from the styleManager
     * PARAM: querrySelectors: an array comprised of Selectors (from the elements selectors)
     * TODO: this the sub method of this class could still need some refactoring, and clearafication
     * TODO: somehow you need to have a flag when a selector has a state that cascade doesnt have
     */
    static func selectorWeights(_ style:IStyle,_ querrySelectors:Array<ISelector>)->Array<SelectorWeight>? {//
        var selectorWeights:Array<SelectorWeight> = []
        cursor = 0/*so that we skip testing the same selector again*/
        for styleSel:ISelector in style.selectors {/*loops through each selector in the style*///Item Item Item Button Text
            let selectorWeight:SelectorWeight? = Utils.selectorWeight(styleSel,querrySelectors)
            if(selectorWeight == nil) {return nil}
            else {selectorWeights.append(selectorWeight!)}
        }
        return selectorWeights
    }
    /**
     * Returns the absolute ancestry as a space delimited string in this format: elementId:classIds#id:states
     * NOTE: this method can also be used for debuging purposes
     */
    static func selectorsString(_ selectors:Array<ISelector>)->String{//TODO: rename to selectorsString
        var string:String = ""
        for i in 0..<selectors.count{
            string += selectorToString(selectors[i]) + (i < selectors.count-1 ? " ":"")
        }
        return string
    }
    /**
     * Returns a single selector (ie: Button#first:over)
     */
    static func selectorString(_ selector:ISelector)->String{// :TODO: rename to selectorString
        var string:String = ""
        if(selector.element != "") { string += selector.element }
        for classId:String in selector.classIds { string += ("."+classId) }
        if(selector.id != "") { string += "#"+selector.id }
        for state:String in selector.states { string += (":"+state) }
        return string
    }
    /**
     * Returns an array of Selector instances from PARAM: string (which is usually from the CSSParser.style function)
     */
    static func selectors(_ string:String)->Array<ISelector>! {
        let selectorNames:Array<String> = StringAsserter.contains(string, " ") ? StringModifier.split(string," ") : [string]
        var styleSelectors:Array<ISelector> = []
        for selectorName  in selectorNames{ styleSelectors.append(selector(selectorName)) }
        return styleSelectors
    }
    /**
     * Returns a Selector instance from PARAM: string (string is usually a style name)
     * NOTE: a Selector is a data container that contains element,classIds,ids and states
     * EXAMPLE: SelectorParser.selector("Button.tab#arrow:down")//element: >Button<classIds: >["tab"]<id: >arrow<states: >["down"]<
     */
    static func selector(_ string:String)->ISelector {
        let matches = RegExp.matches(string, SelectorPattern.pattern)
        var selectorElement:String = ""
        for match:NSTextCheckingResult in matches {
            selectorElement = (match.rangeAt(1).location != NSNotFound) ? match.value(string, 1) : ""
            func classIds()->[String]{
                if match.rangeAt(2).location != NSNotFound {
                    let classIds:String = match.value(string, 2)
                    return classIds.contains(" ") ? StringModifier.split(classIds, " ") : [classIds]
                }else{
                    return []
                }
            }
            let selectorClassIds:[String] = classIds()
            let selectorId = (match.rangeAt(3).location != NSNotFound) ? match.value(string, 3) : ""
            func states()->[String]{
                if match.rangeAt(4).location != NSNotFound {
                    let states:String = RegExp.value(string, match, 4)
                    return states.contains(":") ? StringModifier.split(states, ":") : [states]
                }else{
                    return []
                }
            }
            let selectorStates:[String] = states()
            return Selector(selectorElement,selectorClassIds,selectorId,selectorStates)
        }
        return Selector()
    }
    static func numOfSimilarStates(_ a:ISelector,_ b:ISelector)->Int {
        return SelectorAsserter.hasBothSelectorsStates(a, b) ? ArrayParser.similar(a.states, b.states).count : 0
    }
    static func numOfSimilarClassIds(_ a:ISelector,_ b:ISelector)->Int {
        return SelectorAsserter.hasBothSelectorsClassIds(a, b) ? ArrayParser.similar(a.classIds, b.classIds).count : 0
    }
    /**
     * Returns a Selector instance
     */
    static func compileSelectorWeight(_ styleSel:ISelector,_ querrySelector:ISelector,_ weight:Int)->SelectorWeight{
        let hasElement:Bool = SelectorAsserter.hasElement( styleSel) && SelectorAsserter.hasMatchingElement(styleSel,querrySelector)
        let hasId:Bool = SelectorAsserter.hasId(styleSel) && SelectorAsserter.hasMatchingId(styleSel,querrySelector)
        let numOfSimilarClassIds:Int = SelectorParser.numOfSimilarClassIds(styleSel,querrySelector)
        let hasBothSelectorsClassIds:Bool = SelectorAsserter.hasBothSelectorsClassIds(styleSel,querrySelector)
        let hasClassId:Bool = hasBothSelectorsClassIds && numOfSimilarClassIds > 0 ? ArrayAsserter.contains(styleSel.classIds,querrySelector.classIds,false) : false
        let hasBothSelectorsStates:Bool = SelectorAsserter.hasBothSelectorsStates(styleSel,querrySelector)
        let stateWeight:Int = hasBothSelectorsStates ? Utils.stateWeight(styleSel.states,querrySelector.states) : 0
        let hasStateWeight:Bool = hasBothSelectorsStates && stateWeight > 0
        return SelectorWeight(weight, hasId, hasElement, hasClassId, hasStateWeight, numOfSimilarClassIds, stateWeight)
    }
    //deprecated
    static func selectorToString(_ selector:ISelector)->String{return selectorString(selector)}
    static func string(_ selectors:Array<ISelector>)->String{return selectorsString(selectors)}
}
private class Utils{
    /**
     * Returns a SelectorWeight instance (Asserts if a SelectorWeight should be created, if not it returns null)
     * PARAM: styleSel an Selector instance from styleSelectors
     * PARAM: querrySelectors: an array comprised of Selectors (from the element stack)
     */
    static func selectorWeight(_ styleSel:ISelector,_ querrySelectors:Array<ISelector>)->SelectorWeight?{
        //swift 3 update
        for i in 0..<querrySelectors.count{/*loops through each selector in the stack*///Item Container Item Container Button Text
            let querrySelector:ISelector = querrySelectors[i]
            if(SelectorAsserter.hasCommonality(styleSel, querrySelector)){/*Asserts if the selector in the style should influence the style of the element*/
                let selectorWeight = SelectorParser.compileSelectorWeight(styleSel,querrySelector, i+1)
                SelectorParser.cursor = i+1//TODO: this could possibly also be solved by looping the style inside the stack, but this was a faster fix
                return selectorWeight
            }
        }
        return nil/*if a selectors array in the style has an individual selector that doesn't have anything in common with none of the selector sin the cascade then return false*/
    }
    /**
     * NOTE: Lower index equals more weight (index:0 equals the length of the array in weight, index:1 equals the length of the array minus the index)
     */
    static func stateWeight(_ a:Array<String>,_ b:Array<String>)->Int{
        var weight:Int = 0
        for state:String in a {
            weight += b.count - ArrayParser.index(b,state)/*<--s this really wise? what if it is -1 aka doesn't exist*/
        }
        return weight
    }
}
/**
 * RegExp pattern for the SelectorParser.selector() method
 * //TODO: this could probably be re-written by using backreferensing and if they are valid then ...
 * //TODO: research backreferencing
 */
class SelectorPattern {
    static var elementGroup:String = "^([\\w\\d]+?)?"/*0 or 1 times.*/
    static var subsededWith1:String = "(?=\\#|\\:|\\.|\040|$)"/*must appear and is not included in the match*/
    static var classIdsGroup:String = "(?:\\.([\\w\\d]+?))?"
    static var subsededWith2:String = "(?=\\#|\\:|\040|$)"/*must appear and is not included in the match*/
    static var idsGroup:String = "(?:\\#([\\w\\d]+?))?"
    static var subsededWith3:String = "(?=\\:|\040|$)"/*must appear and is not included in the match*/
    static var statesGroup:String = "(?:\\:([\\w\\d\\:]+?))?"
    static var end:String = "(?=$)"/*must appear and is not included in the match*/
    static var pattern:String = elementGroup + subsededWith1 + classIdsGroup + subsededWith2 + idsGroup + subsededWith3 + statesGroup + end
}

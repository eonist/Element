import Foundation
/**
 * @Note we could move this into an internal utils class of StyleResolver but since Selector class is a public class we might aswell keep this class as a public class aswell
 */
class SelectorParser{
    /**
     * Returns a weight value based on where aSelector is locaeted on the @param b array (higher values means higher priotiy)
     * @param style: originally from the styleManager
     * @param querrySelectors: an array comprised of Selectors (from the element stack)
     * // :TODO: this the sub method of this class could still need some refactoring, and clearafication
     * // :TODO: somehow you need to have a flag when a selector has a state that cascade doesnt have
     */
    class func selectorWeights(style:IStyle,querrySelectors:Array<ISelector>)->Array<SelectorWeight> {//
        var selectorWeights:Array = [];
        CURSOR = 0;/*so that we skip testing the same selector again*/
        for each (var styleSel : Selector in style.selectors){/*loops through each selector in the style*///Item Item Item Button Text
            var selectorWeight:SelectorWeight = Utils.selectorWeight(styleSel,querrySelectors);
            if(selectorWeight == null) return null;
            else selectorWeights.push(selectorWeight);
        }
        return selectorWeights;
    }
    /**
     * Returns the absolute ancestry as a space delimited string in this format: elementId:classIds#id:states
     * @Note this method can also be used for debuging purposes
     */
    class func string(selectors:Array<ISelector>)->String{// :TODO: rename to selectorsString
        var string:String = "";
        for (var i : Int = 0; i < selectors.count; i++) {
            string += selectorToString(selectors[i]) + (i < selectors.count-1 ? " ":"");
        }
        return string;
    }
    /**
     * Returns a single selector (ie: Button#first:over)
     */
    class func selectorToString(selector:ISelector)->String{// :TODO: rename to selectorString
        var string:String = "";
        if(selector.element != "") { string += selector.element }
        for classId:String in selector.classIds { string += ("."+classId) }
        if(selector.id != "") { string += "#"+selector.id }
        for state:String in selector.states { string += (":"+state) }
        return string;
    }
    /**
     * Returns an array of Selector instances from @param string (which is usually from the CSSParser.style function)
     */
    class func selectors(string:String)->Array<ISelector>! {
        let selectorNames:Array<String> = StringAsserter.contains(string, " ") ? StringModifier.split(string," ") : [string]
        var styleSelectors:Array<ISelector> = [];
        for selectorName  in selectorNames{ styleSelectors.append(selector(selectorName)) }
        return styleSelectors
    }
    /**
     * Returns a Selector instance from @param string (string is usually a style name)
     * NOTE: a Selector is a data container that contains element,classIds,ids and states
     * EXAMPLE: SelectorParser.selector("Button.tab#arrow:down")//element: >Button<classIds: >["tab"]<id: >arrow<states: >["down"]<
     */
    class func selector(string:String)->ISelector {
        var selector:ISelector = Selector();
        let matches = RegExp.matches(string, SelectorPattern.pattern)
        for match:NSTextCheckingResult in matches {
            selector.element = (match.rangeAtIndex(1).location != NSNotFound) ? RegExp.value(string, match, 1) : ""
            if match.rangeAtIndex(2).location != NSNotFound {
                let classIds:String = RegExp.value(string, match, 2)
                selector.classIds = classIds.containsString(" ") ? StringModifier.split(classIds, " ") : [classIds]
            }else{
                selector.classIds = []
            }
            selector.id = (match.rangeAtIndex(3).location != NSNotFound) ? RegExp.value(string, match, 3) : ""
            if match.rangeAtIndex(4).location != NSNotFound {
                let states:String = RegExp.value(string, match, 4)
                selector.states = states.containsString(":") ? StringModifier.split(states, ":") : [states]
            }else{
                selector.states = []
            }
        }
        return selector
    }
}
/**
 * RegExp pattern for the SelectorParser.selector() method
 * //TODO: this could probably be re-written by using backreferensing and if they are valid then ...
 * //TODO: research backreferencing
 */
class SelectorPattern {
    static var elementGroup:String = "^([\\w\\d]+?)?"//0 or 1 times.
    static var subsededWith1:String = "(?=\\#|\\:|\\.|\040|$)"//must appear and is not included in the match
    static var classIdsGroup:String = "(?:\\.([\\w\\d]+?))?"
    static var subsededWith2:String = "(?=\\#|\\:|\040|$)"//must appear and is not included in the match
    static var idsGroup:String = "(?:\\#([\\w\\d]+?))?"
    static var subsededWith3:String = "(?=\\:|\040|$)"//must appear and is not included in the match
    static var statesGroup:String = "(?:\\:([\\w\\d\\:]+?))?"
    static var end:String = "(?=$)"//must appear and is not included in the match
    static var pattern:String = elementGroup + subsededWith1 + classIdsGroup + subsededWith2 + idsGroup + subsededWith3 + statesGroup + end
}
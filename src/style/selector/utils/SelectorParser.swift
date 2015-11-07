import Foundation

class SelectorParser{
    //TODO: this could probably be re-written by using backreferensing and if they are valid then ...
    //TODO: research backreferencing
    static var elementGroup:String = "^([\\w\\d]+?)?"//0 or 1 times.
    static var subsededWith1:String = "(?=\\#|\\:|\\.|\040|$)"//must appear and is not included in the match
    static var classIdsGroup:String = "(?:\\.([\\w\\d]+?))?"
    static var subsededWith2:String = "(?=\\#|\\:|\040|$)"//must appear and is not included in the match
    static var idsGroup:String = "(?:\\#([\\w\\d]+?))?"
    static var subsededWith3:String = "(?=\\:|\040|$)"//must appear and is not included in the match
    static var statesGroup:String = "(?:\\:([\\w\\d\\:]+?))?"
    static var end:String = "(?=$)"//must appear and is not included in the match
    static var pattern:String = elementGroup + subsededWith1 + classIdsGroup + subsededWith2 + idsGroup + subsededWith3 + statesGroup + end
    
    /**
     * Returns a Selector instance from @param string (string is usually a style name)
     * NOTE: a Selector is a data container that contains element,classIds,ids and states
     * EXAMPLE: SelectorParser.selector("Button.tab#arrow:down")//element: >Button<classIds: >["tab"]<id: >arrow<states: >["down"]<
     */
    class func selector(string:String)->ISelector {
        var selector:ISelector = Selector();
        let matches = RegExp.matches(string, pattern)
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
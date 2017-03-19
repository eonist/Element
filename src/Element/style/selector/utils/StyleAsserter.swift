import Foundation
class StyleAsserter {
    /**
     * Asserts if PARAM: style is a direct style of the PARAM: stack (the stack is derived from an Element instance)
     * NOTE: the opposite would be an indirect style
     */
    static func direct(_ stack:[ISelector],_ style:IStyle)->Bool {//TODO: rename to isDirect, is it Necessary? StyleAsserter.direct is pretty self explanatory
        //swift 3 update, extra checks to make sure that there are array items to assert
        return stack.count > 0 && style.selectors.count > 0 && SelectorAsserter.hasSimilarity(stack.last!, style.selectors.last!)//<--TODO:You could do .last here
    }
}

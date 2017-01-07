import Foundation
class StyleAsserter {
    /**
     * Asserts if PARAM: style is a direct style of the PARAM: stack (the stack is derived from an Element instance)
     * NOTE: the opposite would be an indirect style
     */
    static func direct(stack:Array<ISelector>,_ style:IStyle)->Bool {//TODO: rename to isDirect, is it Necessary? StyleAsserter.direct is pretty self explanatory
        return SelectorAsserter.hasSimilarity(stack[stack.count-1], style.selectors[style.selectors.count-1])//<--TODO:You could do .last here
    }
}
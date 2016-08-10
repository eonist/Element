import Foundation
class StyleAsserter {
    /**
     * Asserts if @param style is a direct style of the @param stack (the stack is derived from an Element instance)
     * @Note the opposite would be an indirect style
     */
    class func direct(stack:Array<ISelector>,_ style:IStyle)->Bool {//rename to isDirect, is it Necessary? StyleAsserter.direct is pretty self explanatory
        return SelectorAsserter.hasSimilarity(stack[stack.count-1], style.selectors[style.selectors.count-1])
    }
}
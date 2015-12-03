import Foundation

class StyleAsserter {
    /**
    * Asserts if @param style is a direct style of the @param stack (the stack is derived from an Element instance)
    * @Note the opposite would be an indirect style
    */
    class func direct(stack:Array<>,style:IStyle)->Bool {//rename to isDirect
        return SelectorAsserter.hasSimilarity(stack[stack.length-1], style.selectors[style.selectors.length-1]);
    }
}
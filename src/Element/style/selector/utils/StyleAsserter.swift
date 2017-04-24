import Foundation
class StyleAsserter {
    /**
     * Asserts if PARAM: style is a direct style of the PARAM: stack (the stack is derived from an Element instance)
     * NOTE: the opposite would be an indirect style
     */
    static func direct(_ stack:[ISelector],_ style:IStyle)->Bool {//TODO: rename to isDirect, is it Necessary? StyleAsserter.direct is pretty self explanatory
        if let lastStackItem = stack.last, let lastSelector = style.selectors.last{
            return SelectorAsserter.hasSimilarity(lastStackItem, lastSelector)
        }
        return false
    }
    static func alreadyExists(_ style:IStyle,_ styleProperty:IStyleProperty) -> Bool{
        return style.styleProperties.first(where: {$0.name == styleProperty.name && $0.depth == styleProperty.depth}) != nil
    }
}

import Foundation
@testable import Utils

class SelectorAsserter {
    /**
     * Asserts if PARAM: a has a similar element,id,classId or state as PARAM: b
     */
    static func hasSimilarity(_ a:SelectorKind,_ b:SelectorKind)->Bool {
        return hasMatchingElement(a,b) || (hasBothSelectorsIds(a, b) && hasMatchingId(a,b)) || (hasBothSelectorsClassIds(a, b) && hasMatchingClassIds(a, b)) || hasSimilarState(a,b);
    }
    /**
     * Asserts if the selector in the style should influence the style of the element
     */
    static func hasCommonality(_ styleSel:SelectorKind,_ querrySelector:SelectorKind)->Bool {
       let hasMatchingId:Bool = SelectorAsserter.hasMatchingId(styleSel, querrySelector)
       let hasMatchingElement:Bool = SelectorAsserter.hasMatchingElement(styleSel, querrySelector)
       let hasBothSelectorsClassIds:Bool = SelectorAsserter.hasBothSelectorsClassIds(styleSel, querrySelector)
       let hasMatchingClassIds:Bool = hasBothSelectorsClassIds && SelectorAsserter.hasMatchingClassIds(styleSel, querrySelector)/*all styleSel classIds are present in stackSel classIds*/
       let numOfMatchingStates:Int = SelectorParser.numOfSimilarStates(styleSel, querrySelector)
       let hasSimilarState:Bool = SelectorAsserter.hasSimilarState(styleSel, querrySelector)
       let hasStyleSelStates:Bool = SelectorAsserter.hasStates(styleSel)
       let a:Bool = (hasMatchingId || styleSel.id == "")
       let b:Bool = hasMatchingElement || styleSel.element == ""
       let c:Bool = (hasMatchingClassIds || !hasBothSelectorsClassIds)
       let d:Bool = (!hasStyleSelStates || (hasSimilarState && numOfMatchingStates <= querrySelector.states.count))
       return a && b && c && d
    }
    static func hasMatchingElement(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return a.element == b.element
    }
    static func hasMatchingId(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return a.id == b.id
    }
    static func hasMatchingClassIds(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return ArrayAsserter.contains(a.classIds, b.classIds, false)//<----this may be wrong as it compares if the instance has the same variables, but the original code compared reference, which seemed wrong to me
    }
    static func hasBothSelectorsIds(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return a.id != "" && b.id != ""
    }
    static func hasBothSelectorsClassIds(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return a.classIds.count != 0  && b.classIds.count != 0
    }
    static func hasBothSelectorsStates(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return a.states.count != 0 && b.states.count != 0
    }
    static func hasSimilarState(_ a:SelectorKind,_ b:SelectorKind)->Bool {
      return SelectorParser.numOfSimilarStates(a, b) > 0
    }
    static func hasStates(_ selector:SelectorKind)->Bool {
      return selector.states.count != 0
    }
    static func hasElement(_ selector:SelectorKind)->Bool {
      return selector.element != ""
    }
    static func hasId(_ selector:SelectorKind)->Bool {
      return selector.id != ""
    }
}

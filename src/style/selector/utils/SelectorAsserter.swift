import Foundation
@testable import Utils

class SelectorAsserter {
    /**
     * Asserts if PARAM: a has a similar element,id,classId or state as PARAM: b
     */
    static func hasSimilarity(_ a:ISelector,_ b:ISelector)->Bool {
        return hasMatchingElement(a,b) || (hasBothSelectorsIds(a, b) && hasMatchingId(a,b)) || (hasBothSelectorsClassIds(a, b) && hasMatchingClassIds(a, b)) || hasSimilarState(a,b);
    }
    /**
     * Asserts if the selector in the style should influence the style of the element
     */
    static func hasCommonality(_ styleSel:ISelector,_ querrySelector:ISelector)->Bool {
       let hasMatchingId:Bool = SelectorAsserter.hasMatchingId(styleSel, querrySelector)
       let hasMatchingElement:Bool = SelectorAsserter.hasMatchingElement(styleSel, querrySelector)
       let hasBothSelectorsClassIds:Bool = SelectorAsserter.hasBothSelectorsClassIds(styleSel, querrySelector)
       let hasMatchingClassIds:Bool = hasBothSelectorsClassIds && SelectorAsserter.hasMatchingClassIds(styleSel, querrySelector)/*all styleSel classIds are present in stackSel classIds*/
       let numOfMatchingStates:Int = SelectorParser.numOfSimilarStates(styleSel, querrySelector)
       let hasSimilarState:Bool = SelectorAsserter.hasSimilarState(styleSel, querrySelector)
       let hasStyleSelStates:Bool = SelectorAsserter.hasStates(styleSel)
       let a:Bool = (hasMatchingId || styleSel.id == ""/*nil*/)
       let b:Bool = hasMatchingElement || styleSel.element == ""/*nil*/
       let c:Bool = (hasMatchingClassIds || !hasBothSelectorsClassIds)
       let d:Bool = (!hasStyleSelStates || (hasSimilarState && numOfMatchingStates <= querrySelector.states.count))
       return a && b && c && d
    }
    static func hasMatchingElement(_ a:ISelector,_ b:ISelector)->Bool {
      return a.element == b.element
    }
    static func hasMatchingId(_ a:ISelector,_ b:ISelector)->Bool {
      return a.id == b.id
    }
    static func hasMatchingClassIds(_ a:ISelector,_ b:ISelector)->Bool {
      return ArrayAsserter.contains(a.classIds, b.classIds, false)//<----this may be wrong as it compares if the instance has the same variables, but the original code compared reference, which seemed wrong to me
    }
    static func hasBothSelectorsIds(_ a:ISelector,_ b:ISelector)->Bool {
      return a.id != ""/*nil*/ && b.id != ""/*nil*/
    }
    static func hasBothSelectorsClassIds(_ a:ISelector,_ b:ISelector)->Bool {
      return a.classIds.count != 0  /*!= nil*/ && b.classIds.count != 0 /*!= nil*/
    }
    static func hasBothSelectorsStates(_ a:ISelector,_ b:ISelector)->Bool {
      return a.states.count != 0/* != nil*/ && b.states.count != 0/* != nil*/
    }
    static func hasSimilarState(_ a:ISelector,_ b:ISelector)->Bool {
      return SelectorParser.numOfSimilarStates(a, b) > 0
    }
    static func hasStates(_ selector:ISelector)->Bool {
      return selector.states.count != 0 /*!= nil*/
    }
    static func hasElement(_ selector:ISelector)->Bool {
      return selector.element != "" /*nil*/
    }
    static func hasId(_ selector:ISelector)->Bool {
      return selector.id != ""/*nil*/
    }
}

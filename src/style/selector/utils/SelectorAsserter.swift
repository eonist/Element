import Foundation

class SelectorAsserter {
    /**
     * Asserts if @param a has a similar element,id,classId or state as @param b
     */
    class func hasSimilarity(a:ISelector,_ b:ISelector)->Bool {
        return hasMatchingElement(a,b) || (hasBothSelectorsIds(a, b) && hasMatchingId(a,b)) || (hasBothSelectorsClassIds(a, b) && hasMatchingClassIds(a, b)) || hasSimilarState(a,b);
    }
    /**
     * 
     */
    class func hasCommonality(styleSel:ISelector,_ querrySelector:ISelector)->Bool {
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
    class func hasMatchingElement(a:ISelector,_ b:ISelector)->Bool {
      return a.element == b.element
    }
    class func hasMatchingId(a:ISelector,_ b:ISelector)->Bool {
      return a.id == b.id
    }
    class func hasMatchingClassIds(a:ISelector,_ b:ISelector)->Bool {
      return ArrayAsserter.contains(a.classIds, b.classIds, true)//<----this may be wrong as it compares if the instance has the same variables, but the original code compared reference, which seemed wrong to me
    }
    class func hasBothSelectorsIds(a:ISelector,_ b:ISelector)->Bool {
      return a.id != ""/*nil*/ && b.id != ""/*nil*/
    }
    class func hasBothSelectorsClassIds(a:ISelector,_ b:ISelector)->Bool {
      return a.classIds.count != 0  /*!= nil*/ && b.classIds.count != 0 /*!= nil*/
    }
    class func hasBothSelectorsStates(a:ISelector,_ b:ISelector)->Bool {
      return a.states.count != 0/* != nil*/ && b.states.count != 0/* != nil*/
    }
    class func hasSimilarState(a:ISelector,_ b:ISelector)->Bool {
      return SelectorParser.numOfSimilarStates(a, b) > 0
    }
    class func hasStates(selector:ISelector)->Bool {
      return selector.states.count != 0 /*!= nil*/
    }
    class func hasElement(selector:ISelector)->Bool {
      return selector.element != "" /*nil*/
    }
    class func hasId(selector:ISelector)->Bool {
      return selector.id != ""/*nil*/
    }
}
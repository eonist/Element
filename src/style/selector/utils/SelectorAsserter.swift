import Foundation

class SelectorAsserter {
    /**
     * Asserts if @param a has a similar element,id,classId or state as @param b
     */
    class func hasSimilarity(a:Selector,_ b:Selector)->Bool {
        return hasMatchingElement(a,b) || (hasBothSelectorsIds(a, b) && hasMatchingId(a,b)) || (hasBothSelectorsClassIds(a, b) && hasMatchingClassIds(a, b)) || hasSimilarState(a,b);
    }
    /**
     *
     */
    class func hasCommonality(styleSel:Selector,querrySelector:Selector)->Bool {
       var hasMatchingId:Bool = SelectorAsserter.hasMatchingId(styleSel, querrySelector);
       var hasMatchingElement:Bool = SelectorAsserter.hasMatchingElement(styleSel, querrySelector);
       var hasBothSelectorsClassIds:Bool = SelectorAsserter.hasBothSelectorsClassIds(styleSel, querrySelector);
       var hasMatchingClassIds:Bool = hasBothSelectorsClassIds && SelectorAsserter.hasMatchingClassIds(styleSel, querrySelector);/*all styleSel classIds are present in stackSel classIds*/
       var numOfMatchingStates:uint = SelectorParser.numOfSimilarStates(styleSel, querrySelector);
       var hasSimilarState:Bool = SelectorAsserter.hasSimilarState(styleSel, querrySelector);
       var hasStyleSelStates:Bool = SelectorAsserter.hasStates(styleSel);
       var a:Bool = (hasMatchingId || styleSel.id == ""/*nil*/);
       var b:Bool = hasMatchingElement || styleSel.element == ""/*nil*/;
       var c:Bool = (hasMatchingClassIds || !hasBothSelectorsClassIds);
       var d:Bool = (!hasStyleSelStates || (hasSimilarState && numOfMatchingStates <= querrySelector.states.count));
       return a && b && c && d;
    }
    class func hasMatchingElement(a:Selector,_ b:Selector)->Bool {
      return a.element == b.element;
    }
    class func hasMatchingId(a:Selector,_ b:Selector)->Bool {
      return a.id == b.id;
    }
    class func hasMatchingClassIds(a:Selector,_ b:Selector)->Bool {
      return ArrayAsserter.contains(a.classIds, b.classIds, true);//<----this may be wrong as it compares if the instance has the same variables, but the original code compared reference, which seemed wrong to me
    }
    class func hasBothSelectorsIds(a:Selector,_ b:Selector)->Bool {
      return a.id != nil && b.id != nil;
    }
    class func hasBothSelectorsClassIds(a:Selector,_ b:Selector)->Bool {
      return a.classIds != nil && b.classIds != nil;
    }
    class func hasBothSelectorsStates(a:Selector,_ b:Selector)->Bool {
      return a.states != nil && b.states != nil;
    }
    class func hasSimilarState(a:Selector,_ b:Selector)->Bool {
      return SelectorParser.numOfSimilarStates(a, b) > 0;
    }
    class func hasStates(selector:Selector)->Bool {
      return selector.states != nil;
    }
    class func hasElement(selector:Selector)->Bool {
      return selector.element != nil;
    }
    class func hasId(selector:Selector)->Bool {
      return selector.id != nil;
    }
}

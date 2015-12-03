import Foundation

class WeightedStyleAsserter {
    /**
    * Asserts if @param a has priority over @param b (by looking at the variouse weight variables in the WheightStyles mentioned)
    * // :TODO: an idea could be to assign 3 values to elementPriority, classPriority and the other priortity values, 0 for no priority, 1 for equal weight and 2 for priority (this could greatly simplify and speed up this method)
    * // :TODO: this method must be simplified
    * // :TODO: this method must be test with all possible combinations and rethought
    * TODO: You could just do specificity how w3c does it. with assigning points to the different types. 10,100,1000,10000 etc. it works for them, it can work for you
    */
    class func priority(a:WeightedStyle,_ b:WeightedStyle):Bool {// :TODO: rename to assertSpecificity
    //		var temp:String = "Window";//Box#tabBarBox SelectTextButton Text
    var priority:Bool = false;
    var elementPriority:Bool = a.styleWeight.elementWeight >= b.styleWeight.elementWeight;
    //		if(a.name == temp) trace("elementPriority: " + elementPriority);
    var elementCountPriority:Bool = elementCount(a.selectors) > elementCount(b.selectors);
    //		if(a.name == temp) trace("elementCountPriority: " + elementCountPriority);
    var classPriority:Bool = a.styleWeight.classWeight > b.styleWeight.classWeight;
    //		if(a.name == temp) trace("classPriority: " + classPriority);
    var idPriority:Bool = a.styleWeight.idWeight >= b.styleWeight.idWeight;
    //		if(a.name == temp) trace("idPriority: " + idPriority);
    var statePriority:Bool = a.styleWeight.stateWeight > b.styleWeight.stateWeight;
    //		if(a.name == temp) trace("statePriority: " + statePriority);
var hasSelectorPriority:Bool = (idPriority && elementCountPriority) || (classPriority && b.styleWeight.idWeight == 0) || (elementPriority && idPriority/*&& b.styleWeight.idWeight == 0 && b.styleWeight.classWeight == 0*/);
    //		if(a.name == temp)trace("hasSelectorPriority: " + hasSelectorPriority);
    //		trace("b.styleWeight.idWeight: " + b.styleWeight.idWeight);
    //		trace("b.styleWeight.classWeight: " + b.styleWeight.classWeight);
    var hasSelector:Bool = a.styleWeight.elementWeight > 0 || a.styleWeight.classWeight > 0 || a.styleWeight.idWeight > 0;
    var hasState:Bool = a.styleWeight.stateWeight > 0;
    var hasEqualStateWeight:Bool = a.styleWeight.stateWeight == b.styleWeight.stateWeight;
    //		trace("a.styleWeight.stateWeight: " + a.styleWeight.stateWeight);
    //		trace("b.styleWeight.stateWeight: " + b.styleWeight.stateWeight);
    //		trace(a.name+ " hasSelector: " + hasSelector);
    if(hasSelectorPriority && a.styleWeight.stateWeight == 0 && b.styleWeight.stateWeight == 0){/*both have no stateWeight*/
    priority = true;
    //			if(a.name == temp) trace("BLOCK - 0: "+priority);
    }
    else if(hasSelectorPriority && hasEqualStateWeight) {
    priority = assertStateWeight(a, b);
    //			if(a.name == temp) trace("BLOCK - 1: "+priority);
    }
    else if(hasState && statePriority) {
    //			if(a.name == temp) trace("BLOCK - 2");
    priority = true;
    }
    else if(hasSelector && statePriority) {
    //			if(a.name == temp) trace("BLOCK - 3");
    priority = true;
    }
    else if(hasSelector && hasEqualStateWeight) {
    //			trace("a.name: " + a.name);
    //			trace("b.name: " + b.name);
    //			trace("a.styleWeight.elementWeight: " + a.styleWeight.elementWeight);
    //			trace("b.styleWeight.elementWeight: " + b.styleWeight.elementWeight);
    //			trace("a.styleWeight.stateWeight: " + a.styleWeight.stateWeight);
    //			trace("b.styleWeight.stateWeight: " + b.styleWeight.stateWeight);
    priority = a.styleWeight.stateWeight == 0 && b.styleWeight.stateWeight == 0 ? false:assertStateWeight(a, b);/*temp fix*/// :TODO: the problem here is that you need to also have a boolean if both states are 0?!?
    //			if(a.name == temp) trace("BLOCK - 4: "+priority);
    }
    else if(hasState && hasEqualStateWeight){
    priority = assertStateWeight(a, b);
    //			if(a.name == temp) trace("BLOCK - 5: "+priority);
    }
    //		if(a.name == temp) trace(a.name +" HAS PRIORITY OVER: " + b.name+ " == " + priority);
    return priority;
    }
    private static function elementCount(selectors:Array):int{
    var elementCount:int = 0;
    for (var i : int = 0; i < selectors.length; i++) {
    if((selectors[i] as Selector).element != null) elementCount++;
    }
    return elementCount;
    }
    /**
    * Asserts that a "selector.stateWeight" in "a.styleWeight.selectorWeights" has a higher value than a "selector.stateWeight" in "b.styleWeight.selectorWeights"  (the style.weight.stateweight are equal)
    * // :TODO: this may be wrong, what if a.selectorWights.length is more than b.selectorWeights.length????
    * // :TODO: obviously this StyleResolver class is due for renovation so alot of trace code and debug code is left in
    */
    private static function assertStateWeight(a:WeightedStyle,b:WeightedStyle):Boolean{// :TODO: could use a better name
    //		if(a.styleWeight.selectorWeights.length != b.styleWeight.selectorWeights.length) return false;/*<--new code*/
    //		trace("a.styleWeight.selectorWeights.length: " + a.styleWeight.selectorWeights.length);
    //		trace("b.styleWeight.selectorWeights.length: " + b.styleWeight.selectorWeights.length);
    //		if(a.styleWeight.selectorWeights.length > b.styleWeight.selectorWeights.length) return false;/*<--new code 2,caution this may present unknown problems, this code snippet was added to support styles that the parent has a state ie when you want a text tp react to a Button state*/
    //		trace("a.styleWeight.selectorWeights.length: " + a.styleWeight.selectorWeights.length);
    //		trace("b.styleWeight.selectorWeights.length: " + b.styleWeight.selectorWeights.length);
    //		for (var i : int = 0; i < a.styleWeight.selectorWeights.length; i++) {
    //			var aSelectorWeight:SelectorWeight = a.styleWeight.selectorWeights[i];
    //			var bSelectorWeight:SelectorWeight = b.styleWeight.selectorWeights[i];
    //			if(aSelectorWeight.stateWeight > bSelectorWeight.stateWeight) return true;
    //			if(aSelectorWeight.stateWeight < bSelectorWeight.stateWeight) return false;
    //		}
    //loop through a and calc the total stateWeight
    //loop through b and cal the total stateweight
    /*new code start*/// :TODO: nor sure if Things like Button:over Text{fill:blue;} works yet
    var aTotStateWeight:int = 0;
    for each (var aSelectorWeight : SelectorWeight in a.styleWeight.selectorWeights) {
    aTotStateWeight += aSelectorWeight.stateWeight;
    }
    //		trace("aTotStateWeight: " + aTotStateWeight);
    var bTotStateWeight:int = 0;
    for each (var bSelectorWeight : SelectorWeight in b.styleWeight.selectorWeights) {
    bTotStateWeight += bSelectorWeight.stateWeight;
    }
    //		trace("bTotStateWeight: " + bTotStateWeight);
    return aTotStateWeight >= bTotStateWeight;
    /*new code end*/
    //		return true;/*if none of the selector.stateWeigh`s were stronger or weaker then they are all equal*/
    }
}

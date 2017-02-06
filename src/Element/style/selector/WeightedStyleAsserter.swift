import Foundation

class WeightedStyleAsserter {
    /**
     * Asserts if PARAM: a has priority over PARAM: b (by looking at the variouse weight variables in the WheightStyles mentioned)
     * TODO: an idea could be to assign 3 values to elementPriority, classPriority and the other priortity values, 0 for no priority, 1 for equal weight and 2 for priority (this could greatly simplify and speed up this method)
     * TODO: this method must be simplified
     * TODO: this method must be test with all possible combinations and rethought
     * TODO: You could just do specificity how w3c does it. with assigning points to the different types. 10,100,1000,10000 etc. it works for them, it can work for you
     */
    static func priority(_ a:WeightedStyle,_ b:WeightedStyle)->Bool {// :TODO: rename to assertSpecificity
        //var temp:String = "Window"//Box#tabBarBox SelectTextButton Text
        var priority:Bool = false
        let elementPriority:Bool = a.styleWeight.elementWeight >= b.styleWeight.elementWeight
        //if(a.name == temp) print("elementPriority: " + elementPriority)
        let elementCountPriority:Bool = elementCount(a.selectors) > elementCount(b.selectors)
        //if(a.name == temp) print("elementCountPriority: " + elementCountPriority)
        let classPriority:Bool = a.styleWeight.classWeight > b.styleWeight.classWeight
        //if(a.name == temp) print("classPriority: " + classPriority)
        let idPriority:Bool = a.styleWeight.idWeight >= b.styleWeight.idWeight
        //if(a.name == temp) print("idPriority: " + idPriority)
        let statePriority:Bool = a.styleWeight.stateWeight > b.styleWeight.stateWeight
        //if(a.name == temp) print("statePriority: " + statePriority)
        let hasSelectorPriority:Bool = (idPriority && elementCountPriority) || (classPriority && b.styleWeight.idWeight == 0) || (elementPriority && idPriority/*&& b.styleWeight.idWeight == 0 && b.styleWeight.classWeight == 0*/)
        //if(a.name == temp)trace("hasSelectorPriority: " + hasSelectorPriority)
        //print("b.styleWeight.idWeight: " + b.styleWeight.idWeight)
        //print("b.styleWeight.classWeight: " + b.styleWeight.classWeight)
        let hasSelector:Bool = a.styleWeight.elementWeight > 0 || a.styleWeight.classWeight > 0 || a.styleWeight.idWeight > 0
        let hasState:Bool = a.styleWeight.stateWeight > 0
        let hasEqualStateWeight:Bool = a.styleWeight.stateWeight == b.styleWeight.stateWeight
        //print("a.styleWeight.stateWeight: " + a.styleWeight.stateWeight)
        //print("b.styleWeight.stateWeight: " + b.styleWeight.stateWeight)
        //print(a.name+ " hasSelector: " + hasSelector)
        if(hasSelectorPriority && a.styleWeight.stateWeight == 0 && b.styleWeight.stateWeight == 0){/*both have no stateWeight*/
            priority = true
            //if(a.name == temp) trace("BLOCK - 0: "+priority)
        }
        else if(hasSelectorPriority && hasEqualStateWeight) {
            priority = assertStateWeight(a, b)
            //if(a.name == temp) trace("BLOCK - 1: "+priority)
        }
        else if(hasState && statePriority) {
            //if(a.name == temp) trace("BLOCK - 2")
            priority = true
        }
        else if(hasSelector && statePriority) {
            //if(a.name == temp) trace("BLOCK - 3")
            priority = true
        }
        else if(hasSelector && hasEqualStateWeight) {
            //print("a.name: " + a.name)
            //print("b.name: " + b.name)
            //print("a.styleWeight.elementWeight: " + a.styleWeight.elementWeight)
            //print("b.styleWeight.elementWeight: " + b.styleWeight.elementWeight)
            //print("a.styleWeight.stateWeight: " + a.styleWeight.stateWeight)
            //print("b.styleWeight.stateWeight: " + b.styleWeight.stateWeight)
            priority = a.styleWeight.stateWeight == 0 && b.styleWeight.stateWeight == 0 ? false:assertStateWeight(a, b)/*temp fix*/// :TODO: the problem here is that you need to also have a boolean if both states are 0?!?
            //if(a.name == temp) trace("BLOCK - 4: "+priority)
        }
        else if(hasState && hasEqualStateWeight){
            priority = assertStateWeight(a, b)
            //if(a.name == temp) trace("BLOCK - 5: "+priority)
        }
        //if(a.name == temp) print(a.name +" HAS PRIORITY OVER: " + b.name+ " == " + priority)
        return priority
    }
    /**
     *
     */
    private static func elementCount(_ selectors:Array<ISelector>)->Int{
        var elementCount:Int = 0
        for i in 0..<selectors.count{//<--forEach candidate!?!?
            if((selectors[i] as ISelector).element != ""/*nil*/) {elementCount+=1}
        }
        return elementCount
    }
    /**
     * Asserts that a "selector.stateWeight" in "a.styleWeight.selectorWeights" has a higher value than a "selector.stateWeight" in "b.styleWeight.selectorWeights"  (the style.weight.stateweight are equal)
     * TODO: this may be wrong, what if a.selectorWights.length is more than b.selectorWeights.length????
     * TODO: obviously this StyleResolver class is due for renovation so alot of trace code and debug code is left in
     */
    private static func assertStateWeight(_ a:WeightedStyle,_ b:WeightedStyle)->Bool{// :TODO: could use a better name
        //if(a.styleWeight.selectorWeights.length != b.styleWeight.selectorWeights.length) return false/*<--new code*/
        //print("a.styleWeight.selectorWeights.length: " + a.styleWeight.selectorWeights.length)
        //print("b.styleWeight.selectorWeights.length: " + b.styleWeight.selectorWeights.length)
        //if(a.styleWeight.selectorWeights.length > b.styleWeight.selectorWeights.length) return false/*<--new code 2,caution this may present unknown problems, this code snippet was added to support styles that the parent has a state ie when you want a text tp react to a Button state*/
        //print("a.styleWeight.selectorWeights.length: " + a.styleWeight.selectorWeights.length)
        //print("b.styleWeight.selectorWeights.length: " + b.styleWeight.selectorWeights.length)
        //for (var i : int = 0; i < a.styleWeight.selectorWeights.length; i++) {
        //	var aSelectorWeight:SelectorWeight = a.styleWeight.selectorWeights[i]
        //	var bSelectorWeight:SelectorWeight = b.styleWeight.selectorWeights[i]
        //	if(aSelectorWeight.stateWeight > bSelectorWeight.stateWeight) return true
        //	if(aSelectorWeight.stateWeight < bSelectorWeight.stateWeight) return false
        //}
        //loop through a and calc the total stateWeight
        //loop through b and cal the total stateweight
        /*new code start*/// :TODO: not sure if Things like Button:over Text{fill:blue;} works yet
        var aTotStateWeight:Int = 0
        for aSelectorWeight:SelectorWeight in a.styleWeight.selectorWeights {
            aTotStateWeight += aSelectorWeight.stateWeight
        }
        //print("aTotStateWeight: " + aTotStateWeight)
        var bTotStateWeight:Int = 0
        for bSelectorWeight:SelectorWeight in b.styleWeight.selectorWeights {
            bTotStateWeight += bSelectorWeight.stateWeight
        }
        //print("bTotStateWeight: " + bTotStateWeight)
        return aTotStateWeight >= bTotStateWeight
        /*new code end*/
        //return true/*if none of the selector.stateWeigh`s were stronger or weaker then they are all equal*/
    }
}

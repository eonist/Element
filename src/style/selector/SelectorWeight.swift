import Foundation
/**
 * @Note "Selectorparser","WeightdStyleAsserter" and "StyleWeight" all make use of this class
 */
class SelectorWeight {
    var weight:UInt;
    var hasId:Bool;
    var hasElement:Bool;
    var hasClassId:Bool;
    var hasState:Bool;
    var numOfSimilarClassIds:UInt;
    var stateWeight:UInt;
    init(_ weight:UInt,_ hasId:Bool,_ hasElement:Bool,_ hasClassId:Bool,_ hasState:Bool,_ numOfSimilarClassIds:UInt,_ stateWeight:UInt) {// :TODO: shouldnt this be in this order: hasElement,hasClassId,classmatchcount,hasId,hasState has stateweight??
       self.weight = weight;
       self.hasId = hasId;
       self.hasElement = hasElement;
       self.hasClassId = hasClassId;
       self.hasState = hasState;
       self.numOfSimilarClassIds = numOfSimilarClassIds;
       self.stateWeight = stateWeight;
    }
}
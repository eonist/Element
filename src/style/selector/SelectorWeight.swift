import Foundation
/**
 * NOTE: "Selectorparser","WeightdStyleAsserter" and "StyleWeight" all make use of this class
 */
class SelectorWeight {
    private(set) var weight:Int
    private(set) var hasId:Bool
    private(set) var hasElement:Bool
    private(set) var hasClassId:Bool
    private(set) var hasState:Bool
    private(set) var numOfSimilarClassIds:Int
    private(set) var stateWeight:Int
    init(_ weight:Int,_ hasId:Bool,_ hasElement:Bool,_ hasClassId:Bool,_ hasState:Bool,_ numOfSimilarClassIds:Int,_ stateWeight:Int) {// :TODO: shouldnt this be in this order: hasElement,hasClassId,classmatchcount,hasId,hasState has stateweight??
       self.weight = weight
       self.hasId = hasId
       self.hasElement = hasElement
       self.hasClassId = hasClassId
       self.hasState = hasState
       self.numOfSimilarClassIds = numOfSimilarClassIds
       self.stateWeight = stateWeight
    }
}
import Foundation
/**
 * NOTE: "Selectorparser","WeightdStyleAsserter" and "StyleWeight" all make use of this class
 */
struct SelectorWeight {
    let weight:Int
    let hasId:Bool
    let hasElement:Bool
    let hasClassId:Bool
    let hasState:Bool
    let numOfSimilarClassIds:Int
    let stateWeight:Int
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
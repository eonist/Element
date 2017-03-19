import Foundation
/**
 * // :TODO: move into its own class? if other classses uses this code yes if not then no!
 */
class StyleWeight {
    var selectorWeights:[SelectorWeight]
    var idWeight:Int = 0
    var elementWeight:Int = 0
    var classWeight:Int = 0
    var stateWeight:Int = 0
    init(_ selectorWeights:[SelectorWeight]) {
       self.selectorWeights = selectorWeights
       for selectorItemWeight:SelectorWeight in selectorWeights {
          self.elementWeight += selectorItemWeight.hasElement ? selectorItemWeight.weight : 0
          self.classWeight += selectorItemWeight.hasClassId ? selectorItemWeight.weight : 0
          self.idWeight += selectorItemWeight.hasId ? selectorItemWeight.weight : 0
          self.stateWeight += selectorItemWeight.hasState ? selectorItemWeight.weight : 0
       }
    }
}

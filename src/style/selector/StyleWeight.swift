import Foundation
/**
 * // :TODO: move into its own class? if other classses uses this code yes if not then no!
 */
class StyleWeight {
    var selectorWeights:Array<SelectorWeight>;
    var idWeight:UInt = 0;
    var elementWeight:UInt = 0;
    var classWeight:UInt = 0;
    var stateWeight:UInt = 0;
    init(selectorWeights:Array<SelectorWeight>) {
       self.selectorWeights = selectorWeights;
       for selectorItemWeight : SelectorWeight in selectorWeights {
          self.elementWeight += selectorItemWeight.hasElement ? selectorItemWeight.weight : 0;
          self.classWeight += selectorItemWeight.hasClassId ? selectorItemWeight.weight : 0;
          self.idWeight += selectorItemWeight.hasId ? selectorItemWeight.weight : 0;
          self.stateWeight += selectorItemWeight.hasState ? selectorItemWeight.weight : 0;
       }
    }
}

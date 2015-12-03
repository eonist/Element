import Foundation
/**
 * // :TODO: move into its own class? if other classses uses this code yes if not then no!
 */
 
//continue here


class StyleWeight {
    var selectorWeights:Array<SelectorWeight>;
    var idWeight:UInt;
    var elementWeight:UInt;
    var classWeight:UInt;
    var stateWeight:UInt;
    init(selectorWeights:Array<SelectorWeight>) {
       self.selectorWeights = selectorWeights;
       for  selectorItemWeight : SelectorWeight in selectorWeights {
          self.elementWeight += selectorItemWeight.hasElement ? selectorItemWeight.weight : 0;
          self.classWeight += selectorItemWeight.hasClassId ? selectorItemWeight.weight : 0;
          self.idWeight += selectorItemWeight.hasId ? selectorItemWeight.weight : 0;
          self.stateWeight += selectorItemWeight.hasState ? selectorItemWeight.weight : 0;
       }
    }
}

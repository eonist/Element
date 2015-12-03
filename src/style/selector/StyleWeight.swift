import Foundation
/**
 * // :TODO: move into its own class? if other classses uses this code yes if not then no!
 */
class StyleWeight {
    var selectorWeights:Array;
    var idWeight:uint;
    var elementWeight:uint;
    var classWeight:uint;
    var stateWeight:uint;
    public function StyleWeight(selectorWeights:Array) {
       self.selectorWeights = selectorWeights;
       for each (var selectorItemWeight : SelectorWeight in _selectorWeights) {
          self.elementWeight += selectorItemWeight.hasElement ? selectorItemWeight.weight : 0;
          self.classWeight += selectorItemWeight.hasClassId ? selectorItemWeight.weight : 0;
          self.idWeight += selectorItemWeight.hasId ? selectorItemWeight.weight : 0;
          self.stateWeight += selectorItemWeight.hasState ? selectorItemWeight.weight : 0;
       }
    }
}

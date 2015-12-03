import Foundation


/**
 *
 * @Note "Selectorparser","WeightdStyleAsserter" and "StyleWeight" all make use of this class
 */
class SelectorWeight {
    private var weight:UInt;
    private var hasId:Bool;
    private var hasElement:Bool;
    private var hasClassId:Bool;
    private var hasState:Bool;
    private var numOfSimilarClassIds:UInt;
    private var stateWeight:UInt;
    init(weight:UInt,hasId:Bool,hasElement:Bool,hasClassId:Bool,hasState:Bool,numOfSimilarClassIds:UInt,stateWeight:UInt) {// :TODO: shouldnt this be in this order: hasElement,hasClassId,classmatchcount,hasId,hasState has stateweight??
    weight = weight;
    hasId = hasId;
    hasElement = hasElement;
    hasClassId = hasClassId;
    hasState = hasState;
    numOfSimilarClassIds = numOfSimilarClassIds;
    stateWeight = stateWeight;
    }
    //----------------------------------
    //  getters / setters
    //----------------------------------
    public function get weight() : uint {
    return _weight;
    }
    public function get hasId() : Boolean {
    return _hasId;
    }
    public function get hasElement() : Boolean {
    return _hasElement;
    }
    public function get hasClassId() : Boolean {
    return _hasClassId;
    }
    public function get hasState() : Boolean {
    return _hasState;
    }
    public function get numOfSimilarClassIds() : uint {
    return _numOfSimilarClassIds;
    }
    public function get stateWeight() : uint {
    return _stateWeight;
    }
    public function set weight(weight : uint) : void {
    _weight = weight;
    }
    public function set hasId(hasId : Boolean) : void {
    _hasId = hasId;
    }
    public function set hasElement(hasElement : Boolean) : void {
    _hasElement = hasElement;
    }
    public function set hasClassId(hasClassId : Boolean) : void {
    _hasClassId = hasClassId;
    }
    public function set hasState(hasState : Boolean) : void {
    _hasState = hasState;
    }
    public function set numOfSimilarClassIds(numOfSimilarClassIds : uint) : void {
    _numOfSimilarClassIds = numOfSimilarClassIds;
    }
    public function set stateWeight(stateWeight : uint) : void {
    _stateWeight = stateWeight;
    }
}


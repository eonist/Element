import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Include isCheckable? what use would it have?, you could add that via an extension
 */
class CheckEvent2:Event{
    
    let state:CheckedState
    init(state:CheckedState, origin:NSView){
        self.state = state
        super.init(EventType.check2.rawValue, origin)
    }
}
extension CheckEvent2{
    enum EventType:String{//We use enum so we can use dot syntax
        case check2 = "checkEvent2Check"
    }
    var checked:Bool {return state == .checked}//simple bool getter
}
extension Event{
    func assert(_ type:CheckEvent2.EventType) -> Bool{
        return self.type == type.rawValue
    }
}




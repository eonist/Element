import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Include isCheckable? what use would it have?, you could add that via an extension
 */
class CheckEvent2:Event{
    enum EventType:String{
        case check2 = "checkEvent2Check"
    }
    let state:CheckedState
    init(state:CheckedState, origin:NSView){
        self.state = state
        super.init(EventType.check2.rawValue, origin)
    }
}

extension Event{
    func assert(_ type:CheckEvent2.EventType) -> Bool{
        return self.type == type.rawValue
    }
}




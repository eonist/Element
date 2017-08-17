import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Include isCheckable? what use would it have?, you could add that via an extension
 */
class CheckEvent:Event{
    var isChecked:Bool
    static var check:String = "checkEventCheck"//CheckEventType.check.rawValue
    init(_ type:String, _ isChecked:Bool, _ origin:NSView){
        self.isChecked = isChecked
        super.init(type, origin)
    }
}
//enum CheckEventType:String{
//    case check = "checkEventCheck"
//}
//extension Event{
//    func assert(_ type:CheckEventType) -> Bool{
//        return self.type == type.rawValue
//    }
//}


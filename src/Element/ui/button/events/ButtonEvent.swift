import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Add for touch as well: touchUp,Down,upOutSide,upInside,out,over etc
 * NOTE: Reading the event.location can be done by reading the localPos from the button it self
 */
class ButtonEvent:Event{
    static let down:String = ButtonEventType.down.hashValue.string
    static let up:String = ButtonEventType.up.hashValue.string
    static let upInside:String = ButtonEventType.upInside.hashValue.string
    static let upOutside:String = ButtonEventType.upOutside.hashValue.string
    static let out:String = ButtonEventType.out.hashValue.string
    static let over:String = ButtonEventType.over.hashValue.string
    /*Right*/
    static var rightMouseDown:String = ButtonEventType.rightMouseDown.hashValue.string
    weak var event:NSEvent?
    init(_ type:String = "", _ origin:AnyObject,_ event:NSEvent? = nil){
        self.event = event
        super.init(type, origin)
    }
}
enum ButtonEventType{
    case down,up,upInside,upOutside,out,over,rightMouseDown
}

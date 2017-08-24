import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Add for touch as well: touchUp,Down,upOutSide,upInside,out,over etc
 * NOTE: Reading the event.location can be done by reading the localPos from the button it self
 */
class ButtonEvent:Event{
    static let down:String = ButtonEventType.down.rawValue
    static let up:String = ButtonEventType.up.rawValue
    static let upInside:String = ButtonEventType.upInside.rawValue
    static let upOutside:String = ButtonEventType.upOutside.rawValue
    static let out:String = ButtonEventType.out.rawValue
    static let over:String = ButtonEventType.over.rawValue
    /*Right*/
    static var rightMouseDown:String = ButtonEventType.rightMouseDown.rawValue
    weak var event:NSEvent?
    init(_ type:String = "", _ origin:AnyObject,_ event:NSEvent? = nil){
        self.event = event
        super.init(type, origin)
    }
}
enum ButtonEventType:String{
    case down = "buttonEventDown"
    case up = "buttonEventUp"
    case upInside = "buttonEventUpInside"
    case upOutside = "buttonEventUpOutside"
    case out = "buttonEventOut"
    case over = "buttonEventOver"
    case rightMouseDown = "buttonEventRightMouseDown"
}
extension Event{
    func assert(_ type:ButtonEventType, id:String? = nil) -> Bool{
        return self.type == type.rawValue && (self.origin as? ElementKind)?.id == id
    }
    func assert(_ type:ButtonEventType, _ origin:AnyObject?) -> Bool{
        return self.type == type.rawValue && self.origin === origin
    }
 
    
}

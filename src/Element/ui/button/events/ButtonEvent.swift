import Cocoa
@testable import Utils
/**
 * TODO: Add for toutch as well: toutchUp,Down,upOutSide,upInside,out,over etc
 */
class ButtonEvent:Event{
    static var down:String = "buttonEventDown"
    static var up:String = "buttonEventUp"/*<--New*/
    static var upInside:String = "buttonEventUpInside"
    static var upOutside:String = "buttonEventUpOutside"
    static var out:String = "buttonEventOut"
    static var over:String = "buttonEventOut"
    /*weak var event:NSEvent?
     init(_ type:String = "", _ origin:AnyObject,_ event:NSEvent? = nil){
     self.event = event
     super.init(type, origin)
     }*/
}

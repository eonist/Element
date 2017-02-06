import Foundation
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
}

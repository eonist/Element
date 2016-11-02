import Foundation

class ScrollWheelEvent:Event{
    static let enter:String = "scrollWheelEnter"//possibly rename to engage
    static let exit:String = "scrollWheelExit"//possibly rename to disEngage
    static let exitAndStationary:String = "scrollWheelExitAndStationary"
}
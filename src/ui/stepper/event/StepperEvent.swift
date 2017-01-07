import Cocoa

class StepperEvent:Event{
    static var change:String = "stepperEventChange"
    var value:CGFloat
    init(_ type:String, _ value:CGFloat, _ origin:NSView,_ immediate:AnyObject){
        self.value = value
        super.init(type, origin)
    }
}
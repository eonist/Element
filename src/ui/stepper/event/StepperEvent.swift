import Cocoa

class StepperEvent :Event{
    static var update : String = "stepperEventUpdate"
    var value:CGFloat
    init(_ type:String, _ value:CGFloat, _ origin:NSView){
        self.value = value
        super.init(type, origin)
    }
}

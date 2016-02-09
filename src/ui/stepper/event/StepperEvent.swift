import Cocoa

class StepperEvent :Event{
    static var change : String = "stepperEventChange"
    var value:CGFloat
    init(_ type:String, _ value:CGFloat, _ origin:NSView){
        self.value = value
        super.init("", origin)
    }
}

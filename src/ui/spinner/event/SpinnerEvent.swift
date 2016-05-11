import Cocoa

class SpinnerEvent :Event{
    static var change : String = "spinnerEventChange"
    var value:CGFloat
    init(_ type:String, _ value:CGFloat, _ origin:NSView,_ immediate:AnyObject){
        self.value = value
        super.init(type, origin/*, immediate*/)
    }
}
import Cocoa
/**
 * // :TODO: include isCheckable? what use would it have?
 */
class CheckEvent:Event{
    var isChecked:Bool;
    static var check:String = "checkEventCheck";
    init(_ type:String, _ isChecked:Bool, _ origin:NSView/*, _ immediate:AnyObject*/){
        self.isChecked = isChecked
        super.init(type, origin/*, immediate*/)
    }
}
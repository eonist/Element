import Foundation

class CheckGroupEvent:Event {
    static var change:String = "checkGroupChange";
    init(_ type:String, _ origin: AnyObject,_ checkable:ICheckable? = nil) {
        super(type);
    }
}

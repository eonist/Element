import Foundation

class SelectGroupEvent:Event {
    static var change:String = "selectGroupChange";/*this event is dispatched after the _selected variable is set in the SelectGroup instance*/// :TODO: possibly rename to SELECT_GROUP_SELECTED
    static var select : String = "selectGroupSelect";/*This event is dispatched before the _selected variable is set in the SelectGroup instance*/
    //static var deSelect : String = "selectGroupDeSelect";
    var selectable : ISelectable
    init(_ type: String, _ origin: AnyObject,_ selectable:ISelectable = nil) {
        self.selectable = selectable
        super.init(type,origin)
    }
}

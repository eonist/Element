import Foundation
/**
 * NOTE: It would be convenient to make an extension that could return the selected
 */
class SelectGroupEvent:Event {
    static var change:String = "selectGroupChange";/*this event is dispatched after the _selected variable is set in the SelectGroup instance*/// :TODO: possibly rename to SELECT_GROUP_SELECTED
    static var select:String = "selectGroupSelect";/*This event is dispatched before the _selected variable is set in the SelectGroup instance*/
    //static var deSelect : String = "selectGroupDeSelect"
    var selectable : ISelectable?//TODO: rename to selected
    init(_ type: String, _ selectable:ISelectable? = nil, _ origin: AnyObject) {
        self.selectable = selectable
        super.init(type,origin)
    }
}
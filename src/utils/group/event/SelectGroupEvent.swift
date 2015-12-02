import Foundation

class SelectGroupEvent {
    static var selectGroupChange:String = "selectGroupChange";/*this event is dispatched after the _selected variable is set in the SelectGroup instance*/// :TODO: possibly rename to SELECT_GROUP_SELECTED
    static var selectGroupSelect : String = "selectGroupSelect";/*This event is dispatched before the _selected variable is set in the SelectGroup instance*/
    static var selectGroupDeSelect : String = "selectGroupDeSelect";
}

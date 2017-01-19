import Foundation
@testable import Utils

class CheckGroupEvent:Event {
    static var change:String = "checkGroupChange"/*this event is dispatched after the checked variable is set in the CheckGroup instance*///
    static var check:String = "checkGroupCheck"/*This event is dispatched before the checked variable is set in the CheckGroup instance*/
    var checked:ICheckable?
    init(_ type:String, _ checked:ICheckable? = nil,_ origin:AnyObject) {
        self.checked = checked
        super.init(type,origin)
    }
}

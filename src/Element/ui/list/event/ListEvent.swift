import Foundation
@testable import Utils

class ListEvent:Event{
    static var select:String = "listEventSelect"
    var index:Int
    init(_ type:String, _ index:Int, _ origin:AnyObject) {
        self.index = index
        super.init(type, origin)
    }
}
extension ListEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not referencing the item directly
     * NOTE: You may have to reconsider this as the selected item may have de-selected before the event arrives (think cpu threads etc)
     */
    var selected:ISelectable{
        return (origin as! DEPRECATED_IList).lableContainer!.subviews[index] as! ISelectable
    }
}

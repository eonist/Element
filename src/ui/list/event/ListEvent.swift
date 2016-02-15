import Foundation

class ListEvent : Event{
    static var select : String = "listEventSelect";
    private var index : Int
    init(_ type: String, _ index:Int, _ origin: AnyObject) {
        self.index = index
        super.init(type, origin)
    }
}
extension ListEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not referencing the item directly
     */
    var selected:ISelectable{
        return (origin as! IList).lableContainer!.subviews[index] as! ISelectable
    }
}
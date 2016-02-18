import Foundation

class SliderEvent :Event{

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
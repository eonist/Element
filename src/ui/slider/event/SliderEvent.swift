import Foundation

class SliderEvent :Event{

}
extension ListEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not referencing the item directly
     */
    var progress:CGFloat{
        return (origin as! ISlider).progress
    }
}
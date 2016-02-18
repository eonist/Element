import Foundation

class SliderEvent :Event{
    static var change:String = "sliderEventChange";
}
extension ListEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not storing any variables
     */
    var progress:CGFloat{
        return (origin as! ISlider).progress
    }
}
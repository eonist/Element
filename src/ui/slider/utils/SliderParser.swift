import Foundation

class SliderParser {
    /**
     * Returns a slider thumbSize
     * @param scalar
     * @param sliderSize (thumbWidth or thumbHeight)
     * @param scrollBarSize (scrollBarWidth/scrollBarHeight)
     * @Note: Makes sure that the slider thumb is never to small or to big.
     */
    class func thumbSize(var scalar:CGFloat, _ sliderSize:CGFloat)->CGFloat {
        scalar = Swift.min(scalar,1)
        var size:CGFloat = round(sliderSize * scalar)
        size = Swift.max(size,round(sliderSize/10))/*Makes sure thumbsize isn't smaller than a 10th of the slidersize*/
        return size
    }
}

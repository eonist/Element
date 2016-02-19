import Foundation

class SliderParser {
    /**
     * Returns a slider thumbSize
     * @param scalar
     * @param sliderSize (thumbWidth or thumbHeight)
     * @param scrollBarSize (scrollBarWidth/scrollBarHeight)
     * @Note: Makes sure that the slider thumb is never to small or to big.
     */
    class func thumbSize(scalar:Number, sliderSize:Number)->CGFloat {
        scalar = Math.min(scalar,1);
        var size:CGFloat = Math.round(sliderSize * scalar);
        size = Math.max(size,Math.round(sliderSize/10));/*Makes sure thumbsize isnt smaller than a 10th of the slidersize*/
        return size;
    }
}

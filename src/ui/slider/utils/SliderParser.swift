import Foundation

class SliderParser {
    /**
     * Asserts and returns a boolean value that determines if slider should be visible.
     */
    class func assertSliderVisibility(scalar:CGFloat) -> Bool {
        return scalar < 1
    }
    /**
     * Returns a slider thumbSize
     * @param scalar
     * @param sliderSize (thumbWidth or thumbHeight)
     * @param scrollBarSize (scrollBarWidth/scrollBarHeight)
     * @Note: Makes sure that the slider thumb is never to small or to big.
     */
    class func thumbSize(var scalar:CGFloat, _ sliderSize:CGFloat) -> CGFloat {
        scalar = Swift.min(scalar,1)
        var size:CGFloat = round(sliderSize * scalar)
        size = Swift.max(size,round(sliderSize/10))/*Makes sure thumbsize isn't smaller than a 10th of the slidersize*/
        return size
    }
    /**
     * Returns the progress
     * @param y in most cases the itemContainer.y value
     * @param height in most cases the list.height
     * @param totalHeight the total height of all visible items
     * @Note its tempting to just pass a list:IList here but treeList doesnt impliment IList  and TreeList uses this method
     */
    class func progress(y:CGFloat,_ height:CGFloat,_ totalHeight:CGFloat) -> CGFloat {
        return Swift.max(0,Swift.min(1,y / -(totalHeight - height)))
    }
}

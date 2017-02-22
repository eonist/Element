import Foundation

class SliderParser {
    /**
     * Asserts and returns a boolean value that determines if slider should be visible
     */
    static func assertSliderVisibility(_ scalar:CGFloat) -> Bool {
        return scalar < 1
    }
    /**
     * Returns a slider thumbSize
     * PARAM: scalar
     * PARAM: sliderSize (thumbWidth or thumbHeight)
     * PARAM: scrollBarSize (scrollBarWidth/scrollBarHeight)
     * NOTE: Makes sure that the slider thumb is never to small or to big
     */
    static func thumbSize(_ scalar:CGFloat, _ sliderSize:CGFloat) -> CGFloat {
        var scalar = scalar
        scalar = min(scalar,1)/*clamp value to no more than 1*/
        var size:CGFloat = round(sliderSize * scalar)
        size = max(size,round(sliderSize/10))/*Makes sure thumbsize isn't smaller than a 10th of the slidersize*/
        return size
    }
    /**
     * Returns the progress
     * PARAM: y in most cases the itemContainer.y value
     * PARAM: height in most cases the list.height
     * PARAM: totalHeight the total height of all visible items (items.count*itemHeight)
     * NOTE: its tempting to just pass a list:IList here but treeList doesn't impliment IList and TreeList uses this method
     */
    static func progress(_ y:CGFloat,_ height:CGFloat,_ totalHeight:CGFloat) -> CGFloat {
        return max(0,min(1,y / -(totalHeight - height)))
    }
    /**
     * Returns the y value
     * PARAM: height in most cases the list.height
     * PARAM: totalHeight the total height of all visible items
     */
    static func y(_ progress:CGFloat,_ height:CGFloat,_ totalHeight:CGFloat) -> CGFloat {
        let scrollHeight:CGFloat = totalHeight - height
        return -round(progress * scrollHeight)
    }
    /**
     * Returns the interval relative to PARAM: pageHeight, PARAM: maskHeight and PARAM: pixelsPerScroll
     * PARAM: pixelsPerScroll The amount if pixels per scroll tick
     */
    static func interval(_ pageHeight:CGFloat, _ maskHeight:CGFloat, _ pixelsPerScroll:CGFloat) -> CGFloat{
        let interval:CGFloat = pageHeight <= maskHeight ? 1:floor((pageHeight - maskHeight)/pixelsPerScroll)// :TODO: use Math.min or Math.max?
        return interval
    }
}

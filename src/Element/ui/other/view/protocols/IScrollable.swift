import Cocoa
/**
 * Scrollable is for scroling things, basically content within a mask
 */
protocol IScrollable:class {
    var height:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemHeight:CGFloat{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    var lableContainer:Container? {get set}
}

extension IScrollable{
    /**
     * NOTE: Slider list and SliderFastList uses this method
     */
    func scroll(_ theEvent:NSEvent) {
        let interval:CGFloat = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        let curProgress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)
        let progress:CGFloat = SliderListUtils.progress(theEvent.deltaY, interval, curProgress)
        //Swift.print("progress: " + "\(progress)")
        setProgress(progress)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
    /**
     * Moves the itemContainer.y up and down
     */
    func setProgress(_ progress:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        ScrollableUtils.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
}

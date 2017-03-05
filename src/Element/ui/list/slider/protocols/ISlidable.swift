import Foundation

protocol ISlidable:class{
    var height:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemHeight:CGFloat{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    var lableContainer:Container? {get}
    /**/
    var slider:VSlider?{get}
    var sliderInterval:CGFloat?{get set}
    func setProgress(_ progress:CGFloat)
    func updateSlider()
}
extension ISlidable{
    /**
     * Updates the slider interval and the sliderThumbSize (after DP events: add/remove etc)
     */
    func updateSlider(){
        sliderInterval = floor(self.itemsHeight - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
        slider!.setProgressValue(progress)
    }
    func defaultSetProgress(_ progress:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        SlideableUtils.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
}

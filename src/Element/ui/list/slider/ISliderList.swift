import Cocoa
@testable import Utils

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
}
protocol ISliderList:IList,ISlidable {/*Convenience*/
    func scroll(_ theEvent:NSEvent)
}
extension ISliderList{
    /**
     * NOTE: Slider list and SliderFastList uses this method
     */
    func scroll(_ theEvent:NSEvent) {
        let progress:CGFloat = SliderListUtils.progress(theEvent.deltaY, self.sliderInterval!, self.slider!.progress)
        //Swift.print("progress: " + "\(progress)")
        setProgress(progress)/*Sets the target item to correct y, according to the current scrollBar progress*/
        self.slider?.setProgressValue(progress)/*Positions the slider.thumb*/
        if(theEvent.momentumPhase == NSEventPhase.ended){self.slider!.thumb!.setSkinState("inActive")}
        else if(theEvent.momentumPhase == NSEventPhase.began){self.slider!.thumb!.setSkinState(SkinStates.none)}//include may begin here
    }
    
}
class SliderListUtils{
    /**
     * Returns the progress og the sliderList (used when we scroll with the scrollwheel/touchpad)
     */
    static func progress(_ deltaY:CGFloat,_ sliderInterval:CGFloat,_ sliderProgress:CGFloat)->CGFloat{
        let scrollAmount:CGFloat = (deltaY/30)/sliderInterval/*_scrollBar.interval*/
        var currentScroll:CGFloat = sliderProgress - scrollAmount/*The minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)/*Clamps the num between 0 and 1*/
        return currentScroll
    }
}

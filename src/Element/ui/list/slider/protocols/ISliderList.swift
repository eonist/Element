import Cocoa
@testable import Utils

protocol ISliderList:IList,ISlidable {/*Convenience*/
    func scroll(_ theEvent:NSEvent)
}
extension ISliderList{
    
    //Continue here:
        //move this into Scrollable
    
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

import Foundation

protocol Slidable2:Displacable2{
    var interval:CGFloat {get}
    func updateSlider()
    var slider:VSlider?{get}
    var sliderInterval:CGFloat?{get set}//i think this is the same as intervall, remove
}
extension Slidable2{
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
    func hideSlider(){
        Swift.print("🏂 hide slider")
    }
    func showSlider(){
        Swift.print("🏂 show slider")
    }
    /**
     * NOTE: Slider list and SliderFastList uses this method
     */
    func scroll(_ theEvent:NSEvent) {
        let progress:CGFloat = SliderListUtils.progress(theEvent.deltaY, self.sliderInterval!, self.slider!.progress)
        //Swift.print("Slideable.scroll() progress: " + "\(progress)")
        setProgress(progress)/*Sets the target item to correct y, according to the current scrollBar progress*/
        self.slider?.setProgressValue(progress)/*Positions the slider.thumb*/
        if(theEvent.momentumPhase == NSEventPhase.ended){self.slider!.thumb!.setSkinState("inActive")}
        else if(theEvent.momentumPhase == NSEventPhase.began){self.slider!.thumb!.setSkinState(SkinStates.none)}//include may begin here
    }
}

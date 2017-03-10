import Foundation

protocol Slidable2:Displacable2{
    var interval:CGFloat {get}
    func updateSlider()
    var slider:VSlider?{get}
    var sliderInterval:CGFloat?{get set}//i think this is the same as intervall, remove
}
/**
 * ⚠️️ IMPORTANT: Slidable does not override scroll because a SlideView cant detect scroll. SlideScrollView however can access scroll and call hide and show slider. And then use protocol ambiguity to call scroll on the Scrollable after
 */
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
        //self.slider!.thumb!.setSkinState("inActive")
        if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}/*only fade out if the state is none, aka not over*/
        //slider?.thumb?.fadeOut()
    }
    func showSlider(){
        Swift.print("🏂 show slider")
        //self.slider!.thumb!.setSkinState(SkinStates.none)
        slider!.thumb!.fadeIn()
    }
}

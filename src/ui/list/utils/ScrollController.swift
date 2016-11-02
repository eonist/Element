import Cocoa

class ScrollController {
    var sliderList:ISliderList
    init(_ sliderList:ISliderList){
        self.sliderList = sliderList
    }
    func scrollWheel(theEvent:NSEvent) {
        let currentScroll:CGFloat = SliderListUtils.progress(theEvent.deltaY, sliderList.sliderInterval!, sliderList.slider!.progress)
        ListModifier.scrollTo(sliderList,currentScroll) /*Sets the target item to correct y, according to the current scrollBar progress*/
        sliderList.slider?.setProgressValue(currentScroll)
        if(theEvent.momentumPhase == NSEventPhase.Ended){sliderList.slider!.thumb!.setSkinState("inActive")}
        else if(theEvent.momentumPhase == NSEventPhase.Began){sliderList.slider!.thumb!.setSkinState(SkinStates.none)}//include may begin here
    }
}
import Cocoa
/**
 * TODO: Add support for rubberband behaviour even if there is no need for scrolling
 * TODO: make the top and bottom values when scrolling absolutly pinned to 0 and 1. There should be a final tick that cooresponds to these values in the Mover class
 */
class RBSliderList:List {
    var scrollController:RBScrollController?
    var slider:VSlider?
    private var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("RBSliderList.width: " + "\(width)")
        Swift.print("RBSliderList.height: " + "\(height)")
        scrollController = RBScrollController(self,CGRect(0,0,width,height),CGRect(0,0,width,ListParser.itemsHeight(self)))
        /*slider*/
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
    }
    /**
     * PARAM value: is the final y value for the lableContainer
     */
    func setProgress(value:CGFloat){
        //Swift.print("RBSliderList.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value
        let scalar:CGFloat = value / -(ListParser.itemsHeight(self) - height)/*get the the scalar values from value.*/
        //Swift.print("RBSliderList.setProgress scalar: " + "\(scalar)")
        // Swift.print("setProgressValue.start")
        slider?.setProgressValue(scalar)
        //Swift.print("setProgressValue.end")
    }
    override func scrollWheel(theEvent:NSEvent) {
        scrollController?.scrollWheel(theEvent)//forward the event
        if(theEvent.phase == NSEventPhase.Changed){setProgress(scrollController!.mover.result)}/*direct manipulation*/
    }
    func onSliderChange(sliderEvent:SliderEvent){
        ListModifier.scrollTo(self,sliderEvent.progress)
        scrollController?.mover.value = lableContainer!.frame.y
    }
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change,slider)){onSliderChange(event as! SliderEvent)}
        super.onEvent(event)
    }
}
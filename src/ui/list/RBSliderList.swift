import Cocoa
/**
 * TODO: Add support for rubberband behaviour even if there is no need for scrolling
 * TODO: make the top and bottom values when scrolling absolutly pinned to 0 and 1. There should be a final tick that cooresponds to these values in the Mover class
 * NOTE: the mover instance in scrollController moves the labelContainer by calling the setProgress on each tick of the frame animation in the mover object
 */
class RBSliderList:List {
    var scrollController:RBScrollController?
    var slider:VSlider?
    private var sliderInterval:CGFloat?
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("RBSliderList.width: " + "\(width)")
        Swift.print("RBSliderList.height: " + "\(height)")
        scrollController = RBScrollController(setProgress,CGRect(0,0,width,height),CGRect(0,0,width,ListParser.itemsHeight(self)))
        scrollController!.event = onEvent
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
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(ListParser.itemsHeight(self) - height)/*get the the scalar values from value.*/
        // Swift.print("setProgressValue.start")
        slider!.setProgressValue(progressValue!)
        //Swift.print("setProgressValue.end")
    }
    override func scrollWheel(theEvent:NSEvent) {
        scrollController?.scrollWheel(theEvent)//forward the event to the scrollController
        if(theEvent.phase == NSEventPhase.Changed){setProgress(scrollController!.mover.result)}/*direct manipulation*/
        super.scrollWheel(theEvent)//keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to
    }
    func onSliderChange(sliderEvent:SliderEvent){
        ListModifier.scrollTo(self,sliderEvent.progress)
        scrollController?.mover.value = lableContainer!.frame.y
    }
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change,slider)){
            onSliderChange(event.cast())
        }else if(event.assert(ScrollWheelEvent.exit, scrollController)){
            scrollWheelExit()
        }else if(event.assert(ScrollWheelEvent.enter, scrollController)){
            scrollWheelEnter()
        }else if(event.assert(ScrollWheelEvent.exitAndStationary, scrollController)){
            scrollWheelExitedAndIsStationary()
        }
        super.onEvent(event)
    }
}
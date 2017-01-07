import Cocoa
/**
 * NOTE: the mover instance in scrollController moves the labelContainer by calling the setProgress on each tick of the frame animation in the mover object
 * TODO: Add support for rubberband behaviour even if there is no need for scrolling
 * TODO: make the top and bottom values when scrolling absolutly pinned to 0 and 1. There should be a final tick that cooresponds to these values in the Mover class
 * TODO: Maybe create var's that store the enter and exit state.
 * TODO: Create the algorithm that calculates the actual throw speed. By looking at the time that each intervall travles. 
 */
class RBSliderList:List,IRBSliderList{
    /*RubberBand*/
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:Array<CGFloat> = [0,0,0,0,0,0,0,0,0,0]/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    /*Slider*/
    var slider:VSlider?
    private var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("RBSliderList.width: " + "\(width)")
        Swift.print("RBSliderList.height: " + "\(height)")
        /*RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect = CGRect(0,0,width,ListParser.itemsHeight(self))/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, avoids logging missing eventHandler, this has no functionality in this class, but may have in classes that extends this class*/
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
        //TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
        progressValue = value / -(ListParser.itemsHeight(self) - height)/*get the the scalar values from value.*/
        // Swift.print("setProgressValue.start")
        slider!.setProgressValue(progressValue!)
        //Swift.print("setProgressValue.end")
    }
    /**
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(theEvent:NSEvent) {
        scroll(theEvent)//forward the event to the scrollExtension
        if(theEvent.phase == NSEventPhase.Changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(theEvent)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }
    /**
     * EventHandler for the Slider change event
     */
    func onSliderChange(sliderEvent:SliderEvent){
        ListModifier.scrollTo(self,sliderEvent.progress)
        mover!.value = lableContainer!.frame.y
    }
    func scrollWheelEnter(){//2. spring to refreshStatePosition
        Swift.print("RBSliderList.scrollWheelEnter()" + "\(progressValue)")
        slider!.thumb!.fadeIn()
    }
    func scrollWheelExit(){
        Swift.print("RBSliderList.scrollWheelExit()")
    }
    func scrollWheelExitedAndIsStationary(){
        Swift.print("RBSliderList.scrollWheelExitedAndIsStationary() ")
        if(slider?.thumb?.getSkinState() == SkinStates.none){
            slider?.thumb?.fadeOut()
        }
    }
    func scrollAnimStopped(){
        //Swift.print("RBSliderList.scrollAnimStopped()")
        slider!.thumb!.fadeOut()
    }
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change,slider)){
            onSliderChange(event.cast())
        }else if(event.assert(AnimEvent.stopped, mover!)){
            scrollAnimStopped()
        }
        super.onEvent(event)
    }
}
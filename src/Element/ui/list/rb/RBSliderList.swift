import Cocoa
@testable import Utils
/**
 * NOTE: the mover instance in scrollController moves the labelContainer by calling the setProgress on each tick of the frame animation in the mover object
 * NOTE: Alternate name for RubberBand is ElasticDrag. But conceptually Rubber band is Eleastic. RubberBand™
 * TODO: Add support for rubberband behaviour even if there is no need for scrolling
 * TODO: make the top and bottom values when scrolling absolutly pinned to 0 and 1. There should be a final tick that cooresponds to these values in the Mover class
 * TODO: Maybe create var's that store the enter and exit state.
 * TODO: Create the algorithm that calculates the actual throw speed. By looking at the time that each intervall travles. 
 */
class RBSliderList:List, IRBScrollableSlidable {
    /*RubberBand*/
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat] = Array(repeating: 0, count: 10)/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
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
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){
        //Swift.print("RBSliderList.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(ListParser.itemsHeight(self) - height)/*get the the scalar values from value.*/
        slider!.setProgressValue(progressValue!)
    }
    /**
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        scroll(event)//forward the event to the scrollExtension
        if(event.phase == NSEventPhase.changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(with: event)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change,slider)){
            onSliderChange(event.cast())
        }else if(event.assert(AnimEvent.stopped, mover!)){
            scrollAnimStopped()
        }
        super.onEvent(event)
    }
}

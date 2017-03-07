import Cocoa
@testable import Utils

class RBSliderView:RBScrollView,IRBScrollableSlidable/*:SliderView,*/ {
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
    }
    override func onEvent(_ event:Event) {
        Swift.print("event: " + "\(event)")
        if(event === (SliderEvent.change,slider!)){
            setProgress((event as! SliderEvent).progress)
        }/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        (self as IRBScrollable).scroll(event)//forward the event to the scrollExtension
        if(event.phase == NSEventPhase.changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(with: event)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }
}


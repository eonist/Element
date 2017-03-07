import Cocoa
@testable import Utils

class RBSliderView:SliderView,IRBScrollableSlidable/*:SliderView,*/ {
    /*Slider*/
    
    override func resolveSkin() {
        super.resolveSkin()
        
    }
    
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        Swift.print("RBSliderView.scrollWheel()")
        (self as IRBScrollable).scroll(event)//forward the event to the scrollExtension
        if(event.phase == NSEventPhase.changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(with: event)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }
}


import Cocoa
/**
 * Scrollable is for scroling things, basically content within a mask
 */
protocol Scrollable: Displaceable {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

extension Scrollable {
    /**
     * IMPORTANT: as long as this method doesnt recide in the baseClass it can be reached with protocol ambiguity
     * NOTE: You can use the event.deviceDeltaY to check which direction the gesture is moving in
     * NOTE: These methods later call methods that are overridable.
     * NOTE: Slider list and SliderFastList uses this method
     */
    func scroll(_ event:NSEvent) {
        Swift.print("Scrollable2.scroll()")
        if(event.phase != []){//swift 3 update, was -> NSEventPhase.none
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            case []:break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("📜 Scrollable.onScrollWheelChange: \(event)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, progress)
        setProgress(progressVal)/*<-faux progress, its caluclated via delta noramlly*/
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter() {//optional override in subClasses
        Swift.print("📜 Scrollable.onScrollWheelEnter ⚠️️-DEFAULT-DO-NOTHING-⚠️️")
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit() {//optional override in subClasses
        Swift.print("📜 Scrollable.onScrollWheelExit ⚠️️-DEFAULT-DO-NOTHING-⚠️️")
    }
}

import Cocoa
@testable import Utils
/**
 * This protocol exist because other that Lists may want to be Elastic scrollable, like A container of things
 */
protocol IRBScrollable:class,IScrollable{
    var mover:RubberBand?{get set}
    var prevScrollingDeltaY:CGFloat{get set}
    var velocities:[CGFloat]{get set}
    func scrollWheelEnter()
    func scrollWheelExit()
    func scrollWheelExitedAndIsStationary()
    var progressValue:CGFloat?{get set}//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
}
extension IRBScrollable{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){
        Swift.print("RBScrollView.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
    }
    /**
     * NOTE: You can use the event.deviceDeltaY to check which direction the gesture is moving in
     * NOTE: These methods later call methods that are overridable.
     */
    func scroll(_ theEvent:NSEvent) {
        //Swift.print("RBScrollController.scrollWheel()")
        if(theEvent.phase != []){//swift 3 update, was -> NSEventPhase.none
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
            case NSEventPhase.changed:onScrollWheelChange(theEvent)/*Fires everytime there is direct scrollWheel gesture movment.*/
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
    func onScrollWheelChange(_ theEvent:NSEvent){
        //Swift.print("changed")
        prevScrollingDeltaY = theEvent.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        _ = self.velocities.pushPop(theEvent.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        mover!.value += theEvent.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        mover!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    private func onScrollWheelEnter(){
        //Swift.print("onScrollWheelDown")
        mover!.stop()
        mover!.hasStopped = true/*set the stop flag to true*/
        prevScrollingDeltaY = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/
        velocities = Array(repeating: 0, count: 10)/*Reset the velocities*/
        scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    private func onScrollWheelExit(){
        //Swift.print("onScrollWheelUp")
        mover!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        if(prevScrollingDeltaY != 1.0 && prevScrollingDeltaY != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(prevScrollingDeltaY > 0){velocity = NumberParser.max(velocities)}/*Find the most positive velocity value*/
            else{velocity = NumberParser.min(velocities)}/*Find the most negative velocity value*/
            mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            mover!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{/*stationary*/
            mover!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
            scrollWheelExitedAndIsStationary()/*This is only called if you exit scrollWheel when in overshot areas in the slider, think above 0 and bellow 1 in progress*/
        }
        scrollWheelExit()
    }
    func scrollWheelExit() {}
    func scrollWheelEnter() {}
    func scrollWheelExitedAndIsStationary(){}
    func scrollAnimStopped(){}
}

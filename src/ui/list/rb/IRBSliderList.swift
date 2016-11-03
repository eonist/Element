import Cocoa

protocol IRBSliderList:class{
    var mover:RubberBand?{get}
    var prevScrollingDeltaY:CGFloat{get set}
    var velocities:Array<CGFloat>{get set}
    func scrollWheelEnter()
    func scrollWheelExit()
    func scrollWheelExitedAndIsStationary()
}
extension IRBSliderList{
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    func scroll(theEvent:NSEvent) {
        //Swift.print("RBScrollController.scrollWheel()")
        if(theEvent.phase != NSEventPhase.None){
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
            case NSEventPhase.Changed:onScrollWheelChange(theEvent)/*fires everytime there is direct scrollWheel gesture movment.*/
            case NSEventPhase.MayBegin:onScrollWheelEnter()/*can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.Began:onScrollWheelEnter()/*the mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.Ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.Cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            case NSEventPhase.None:break;
            default:break;
        }
    }
    
    /**
     * Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(theEvent:NSEvent){
        //Swift.print("changed")
        prevScrollingDeltaY = theEvent.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        velocities.pushPop(theEvent.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        mover!.value += theEvent.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        mover!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
    }
    /**
     * NOTE: basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        //Swift.print("onScrollWheelDown")
        //Swift.print("view.animators.count: " + "\(view.animators.count)")
        mover!.stop()
        mover!.hasStopped = true/*set the stop flag to true*/
        prevScrollingDeltaY = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover.isDirectlyManipulating = true/*toggle to directManipulationMode*/
        velocities = [0,0,0,0,0,0,0,0,0,0]/*reset the velocities*/
        onEvent(ScrollWheelEvent(ScrollWheelEvent.enter,self))
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        //Swift.print("onScrollWheelUp")
        mover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        mover.isDirectlyManipulating = false
        mover.value = mover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        if(prevScrollingDeltaY != 1.0 && prevScrollingDeltaY != -1.0){/*not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(prevScrollingDeltaY > 0){velocity = NumberParser.max(velocities)}/*find the most positive velocity value*/
            else{velocity = NumberParser.min(velocities)}/*find the most negative velocity value*/
            mover.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            mover.start()//'start the frameTicker here, do this part in parent view or use event or Selector
        }else{/*stationary*/
            mover.start()//this needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick
            onEvent(ScrollWheelEvent(ScrollWheelEvent.exitAndStationary,self))
        }
        onEvent(ScrollWheelEvent(ScrollWheelEvent.exit,self))
    }
}
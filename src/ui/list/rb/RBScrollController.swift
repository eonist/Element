import Cocoa
/**
 * NOTE: You forward the scrollWheel events here
 * NOTE: It all works like a regular MVC system
 *
 * TODO: Create the algorithm that calculates the actual throw speed. By looking at the time that each intervall travles. 
 */


//continue here: you need to set the progress when using the thumb to scroll. So that when you then use the scrollwheel it can pickup the last value
//see the SliderList when you implement this, since it works there

class RBScrollController {
    var frame:CGRect/*represents the visible part of the content*///TODO: could be ranmed to maskRect
    var itemRect:CGRect/*represents the total size of the content*///TODO: could be ranmed to contentRect
    var view:AnimatableView
    var mover:RubberBand
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:Array<CGFloat> = [0,0,0,0,0,0,0,0,0,0]/*represents the velocity resolution of the gesture movment*/
    init(_ view:AnimatableView,_ frame:CGRect, _ itemRect:CGRect){
        self.view = view
        self.frame = frame
        self.itemRect = itemRect
        self.mover = RubberBand(frame,itemRect)
    }
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    func scrollWheel(theEvent: NSEvent) {
        if(theEvent.phase != NSEventPhase.None){
            Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
            case NSEventPhase.Changed://fires everytime there is direct scrollWheel gesture movment.
                Swift.print("changed")
                prevScrollingDeltaY = theEvent.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
                velocities.pushPop(theEvent.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
                mover.value += theEvent.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
                mover.updatePosition()//the mover still governs the resulting value, inorder to get the displacement friction working
            case NSEventPhase.MayBegin:onScrollWheelDown()//can be used to detect if two fingers are touching the trackpad
            case NSEventPhase.Began:onScrollWheelDown()//the mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly
            case NSEventPhase.Ended:onScrollWheelUp();Swift.print("ended")//if you release your touch-gesture and the momentum of the gesture has stopped.
            case NSEventPhase.Cancelled:onScrollWheelUp();Swift.print("cancelled")//this trigers if the scrollWhell gestures goes off the trackpad etc
            case NSEventPhase.None:break;
            default:break;
        }
        //super.scrollWheel(theEvent)//call super if you want to forward the event to the parent view, you do since the parent listen to this event when directly manipulating the motion
    }
    /**
     * NOTE: basically when you enter your scrollWheel gesture
     */
    func onScrollWheelDown(){
        (view as! RBSliderList).slider?.thumb?.fadeIn()
        CVDisplayLinkStop(view.displayLink)
        mover.hasStopped = true/*set the stop flag to true*/
        prevScrollingDeltaY = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover.isDirectlyManipulating = true/*toggle to directManipulationMode*/
        velocities = [0,0,0,0,0,0,0,0,0,0]//reset the velocities
    }
    /**
     * NOTE: basically when you release your scrollWheel gesture
     */
    func onScrollWheelUp(){
        mover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        mover.isDirectlyManipulating = false
        mover.value = mover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        if(prevScrollingDeltaY != 1.0 && prevScrollingDeltaY != -1.0){/*not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(prevScrollingDeltaY > 0){velocity = NumberParser.max(velocities)}/*find the most positive velocity value*/
            else{velocity = NumberParser.min(velocities)}/*find the most negative velocity value*/
            mover.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this cant be additive is because you need to be more immediate when you change direction, this could be done vy assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            CVDisplayLinkStart(view.displayLink)//'start the frameTicker here, do this part in parent view or use event or Selector
        }else{/*stationary*/
            CVDisplayLinkStart(view.displayLink)//this needs to start if you in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick
            if((view as! RBSliderList).slider?.thumb?.getSkinState() == SkinStates.none){
                (view as! RBSliderList).slider?.thumb?.fadeOut()
            }
        }
    }
}



//Continue here: It seems you can only use one CVDisplayLink at the time. Makes sense i guess.
//Things to try: Only use AnimatableView in the Window (maybe event drop the View part and make it only for windows?)
//seems like values doesnt like being written to more than once during anim. Maybe Set this part up differently. See Facebook pop and that other lib how they did this part. Maybe this part of the display() solution? 
//try isolated experiments where you animate 2 variables at the same time color and size for instance
//






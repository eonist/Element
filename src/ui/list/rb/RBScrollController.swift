import Cocoa
/**
 * NOTE: You forward the scrollWheel events here
 * NOTE: It all works like a regular MVC system
 * TODO: Create the algorithm that calculates the actual throw speed. By looking at the time that each intervall travles. 
 * PARAM: frame: represents the visible part of the content //TODO: could be ranmed to maskRect
 * PARAM: itemsRect: represents the total size of the content //TODO: could be ranmed to contentRect
 * TODO: It's possible to decouple this class from the view by using events and a callBack for the frame-ticks
 */
class RBScrollController:EventSender{
    //var view:RBSliderList/*holds a ref to the view*/
    var mover:RubberBand
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:Array<CGFloat> = [0,0,0,0,0,0,0,0,0,0]/*represents the velocity resolution of the gesture movment*/
    init(_ callBack:(CGFloat)->Void,_ frame:CGRect, _ itemRect:CGRect){
        //self.view = view
        mover = RubberBand(Animation.sharedInstance,callBack,frame,itemRect)
        super.init()
        mover.event = onEvent/*Add an eventHandler for the mover object*/
    }
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    func scrollWheel(theEvent:NSEvent) {
        //Swift.print("RBScrollController.scrollWheel()")
        if(theEvent.phase != NSEventPhase.None){
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
            case NSEventPhase.Changed:/*fires everytime there is direct scrollWheel gesture movment.*/
                //Swift.print("changed")
                prevScrollingDeltaY = theEvent.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
                velocities.pushPop(theEvent.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
                mover.value += theEvent.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
                mover.updatePosition()/*the mover still governs the resulting value, inorder to get the displacement friction working*/
            case NSEventPhase.MayBegin:onScrollWheelEnter()/*can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.Began:onScrollWheelEnter()/*the mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.Ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.Cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            case NSEventPhase.None:break;
            default:break;
        }
        //super.scrollWheel(theEvent)//call super if you want to forward the event to the parent view, you do since the parent listen to this event when directly manipulating the motion
    }
    /**
     * NOTE: basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        //Swift.print("onScrollWheelDown")
        
        //Swift.print("view.animators.count: " + "\(view.animators.count)")
        mover.stop()
        mover.hasStopped = true/*set the stop flag to true*/
        prevScrollingDeltaY = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover.isDirectlyManipulating = true/*toggle to directManipulationMode*/
        velocities = [0,0,0,0,0,0,0,0,0,0]/*reset the velocities*/
        super.onEvent(ScrollWheelEvent(ScrollWheelEvent.enter,self))
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
            super.onEvent(ScrollWheelEvent(ScrollWheelEvent.exitAndStationary,self))
        }
        super.onEvent(ScrollWheelEvent(ScrollWheelEvent.exit,self))
    }
    override func onEvent(event:Event) {
        Swift.print("RBScrollController.onEvent()")
        super.onEvent(event)
    }
}
class ScrollWheelEvent:Event{
    static let enter:String = "scrollWheelEnter"
    static let exit:String = "scrollWheelExit"
    static let exitAndStationary:String = "scrollWheelExitAndStationary"
}
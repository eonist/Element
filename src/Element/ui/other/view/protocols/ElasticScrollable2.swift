import Cocoa
@testable import Utils

protocol ElasticScrollable2:Elastic2,Scrollable2{
    func scrollWheelExitedAndIsStationary()
}

extension ElasticScrollable2{
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event.type)")
        //Swift.print("IRBScrollable.onScrollWheelChange")
        prevScrollingDeltaY = event.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        _ = self.velocities.pushPop(event.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        mover!.value += event.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        mover!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
        
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
        //Swift.print("IRBScrollable.onScrollWheelDown")
        mover!.stop()
        mover!.hasStopped = true/*set the stop flag to true*/
        prevScrollingDeltaY = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/
        velocities = Array(repeating: 0, count: 10)/*Reset the velocities*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        mover!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        Swift.print("prevScrollingDeltaY: " + "\(prevScrollingDeltaY)")
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
        //⚠️️scrollWheelExit()
    }
    
    func scrollWheelExitedAndIsStationary(){/*⚠️️override when you need this call⚠️️*/}
}

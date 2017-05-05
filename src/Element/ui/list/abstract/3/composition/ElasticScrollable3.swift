import Cocoa
@testable import Utils
@testable import Element

protocol ElasticScrollable3:Elastic3,Scrollable3 {}
extension ElasticScrollable3{
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelChange : \(event.type)")
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup!.result
        setProgress(p)
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelEnter")
        //moverGroup!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/ //this was moved
        moverGroup!.stop()
        moverGroup!.hasStopped = true/*set the stop flag to true*/
        //Swift.print("moverGroup!.isDirectlyManipulating: " + "\(moverGroup!.isDirectlyManipulating)")
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelExit")
        //Swift.print("iterimScroll.prevScrollingDelta: " + "\(iterimScroll.prevScrollingDelta)")
        moverGroup!.hasStopped = false
        moverGroup!.value = moverGroup!.result
        moverGroup!.start()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelMomentumBegan(_ event:NSEvent) {
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelMomentumBegan")
        moverGroup!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        //moverGroup!.isDirectlyManipulating = false
        moverGroup!.value = moverGroup!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        moverGroup!.velocity = event.scrollingDelta/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
        moverGroup!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*//*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//we must override this or else we get a too loose elastic effect.
}
//func scrollWheelExitedAndIsStationary(){}
//func scrollWheelExitedAndIsStationary()

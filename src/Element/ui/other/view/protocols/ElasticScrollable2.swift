import Cocoa
@testable import Utils

protocol ElasticScrollable2:Elastic2,Scrollable2{}

extension ElasticScrollable2{
    func onScrollWheelEnter() {
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
    }
    func onScrollWheelExit() {
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event)")
        //Swift.print("IRBScrollable.onScrollWheelChange")
        prevScrollingDeltaY = event.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        _ = self.velocities.pushPop(event.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        mover!.value += event.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        mover!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
    }
}

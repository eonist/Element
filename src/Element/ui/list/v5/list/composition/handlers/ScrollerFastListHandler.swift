import Cocoa
@testable import Utils

class ScrollerFastListHandler:ScrollHandler,FastListableDecorator {
    override func onScrollWheelChange(_ event:NSEvent) {
//        Swift.print("ScrollerFastListHandler.onScrollWheelChange")
//        super.onScrollWheelChange(event)
        //Swift.print("ScrollableFastListable3.onScrollWheelChange()")
        let primaryProgress:CGFloat = SliderListUtils.progress(event, dir, interval(dir), progress(dir))
        // setProgress(primaryProgress)//TODO: ⚠️️ this is not good. that you have to call setProgress one after the other.
        super.setProgress(primaryProgress,dir)//we move the containerView as normal
        (fastListable as? FastList5)?.setProgress(primaryProgress)//we use the pos of containerView to move the fastList items around
        //        ScrollFastList3.numOfEvents! += 1
    }
}

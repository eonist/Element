import Cocoa
@testable import Utils
/**
 * New
 */
class ScrollFastList:FastList,ScrollableFast {
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("ScrollFastList.onScrollWheelChange: \(event.type)")
        let progressVal:CGFloat = SliderListUtils.progress(event.delta[dir], interval, progress)
        setProgress(progressVal)
    }
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event:NSEvent) {
        scroll(event)
        //TODO: ⚠️️ you want to do super.scrollWhe...here, as NSView may need it up hirarchy etc
    }
}

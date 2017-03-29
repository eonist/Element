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
        let intrvl = interval
        Swift.print("intrvl: " + "\(intrvl)")
        let prgrs = progress
        Swift.print("prgrs: " + "\(prgrs)")
        let maskVal:CGFloat = maskSize[dir]
        Swift.print("maskVal: " + "\(maskVal)")
        let contentVal:CGFloat = contentSize[dir]
        Swift.print("contentVal: " + "\(contentVal)")
        let itemSze:CGFloat = itemSize[dir]
        Swift.print("itemSze: " + "\(itemSze)")
        let delta:CGFloat = event.delta[dir]
        Swift.print("delta: " + "\(delta)")
        let progressVal:CGFloat = SliderListUtils.progress(event.delta[dir], intrvl, prgrs)
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

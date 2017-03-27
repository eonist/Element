import Cocoa
@testable import Utils
/**
 * New
 */
class ScrollFastList:FastList,ScrollableFast {
    override var itemsHeight: CGFloat {return dp.count * itemHeight}//👈 temp, move into protocol extension, if possible
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
        //TODO: ⚠️️ you want to do super.scrollWhe...here, as NSView may need it up hirarchy etc
    }
}

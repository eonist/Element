import Cocoa
@testable import Utils
/**
 * New
 */
class ScrollFastList:FastList,ScrollableFast {
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     * TODO: ⚠️️ This method can be moved to a where clause extension probably
     */
    override func scrollWheel(with event:NSEvent) {
        scroll(event)
        super.scrollWheel(with: event)
        //TODO: ⚠️️ you want to do super.scrollWhe...here, as NSView may need it up hirarchy etc
    }
}

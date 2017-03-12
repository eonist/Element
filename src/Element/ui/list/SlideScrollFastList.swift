import Cocoa
@testable import Utils
/**
 * TODO: You need to update slider and mover on DP event: see SliderList for implementation
 */
class SlideScrollFastList: SlideFastList,SlidableScrollableFast {
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
        //TODO: ⚠️️ you want to do super.scrollWhe...here, as NSView may need it up hirarchy etc
    }
}

import Cocoa
@testable import Utils

class SlideScrollFastList2:SlideFastList2,SlidableScrollableFast {
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

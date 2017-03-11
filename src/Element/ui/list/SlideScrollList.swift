import Cocoa

class SlideScrollList:SlideView,SlidableScrollable {
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event:NSEvent) {
        scroll(event)
    }
}

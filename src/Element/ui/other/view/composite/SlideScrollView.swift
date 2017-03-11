import Cocoa

class SlideScrollView: SlideView, SlidableScrollable {
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

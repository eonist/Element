import Cocoa

class SlideScrollView2: SlideView, SlidableScrollable {
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

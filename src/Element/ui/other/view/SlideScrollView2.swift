import Foundation

class SlideScrollView2:SlideView2,SlidableScrollable2{
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

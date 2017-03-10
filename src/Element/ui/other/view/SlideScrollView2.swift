import Foundation

class SlideScrollView2:SlideView2,SlidableScrollable2{
    override func scrollWheel(_ event: String) {
        scroll(event)
    }
}

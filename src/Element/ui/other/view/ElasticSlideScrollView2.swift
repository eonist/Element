import Foundation

class ElasticSlideScrollView2:DisplaceView2,ElasticSlidableScrollable2{
    override func scrollWheel(with event: NSEvent) {//you can probably remove this method and do it in base?"!?
        scroll(event)
    }
}

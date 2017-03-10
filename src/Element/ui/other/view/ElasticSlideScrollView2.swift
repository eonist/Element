import Foundation

class ElasticSlideScrollView2:DisplaceView2,ElasticSlidableScrollable2{
    override func scrollWheel(_ event: String) {
        scroll(event)
    }
}

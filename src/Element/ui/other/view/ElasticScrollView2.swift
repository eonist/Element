import Foundation

class ElasticScrollView2:DisplaceView2,ElasticScrollable2{
    override func scrollWheel(_ event: String) {
        scroll(event)
    }
}

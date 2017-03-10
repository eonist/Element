import Cocoa

class ElasticScrollView2:DisplaceView2,ElasticScrollable2{
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

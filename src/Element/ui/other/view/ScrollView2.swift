import Foundation

class ScrollView2:DisplaceView2,Scrollable2{
    override func scrollWheel(_ event: String) {
        scroll(event)
    }
}

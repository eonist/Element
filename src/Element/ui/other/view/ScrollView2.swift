import Cocoa

class ScrollView2:DisplaceView2,Scrollable2{
    override func scrollWheel(with event: NSEvent) {//TODO: move to displaceview
        scroll(event)
    }
}

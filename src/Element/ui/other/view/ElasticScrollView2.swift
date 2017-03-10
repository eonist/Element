import Cocoa
@testable import Utils

class ElasticScrollView2:DisplaceView2,ElasticScrollable2{
    /*RubberBand*/
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat] = Array(repeating: 0, count: 10)/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    override func scrollWheel(with event: NSEvent) {
        scroll(event)
    }
}

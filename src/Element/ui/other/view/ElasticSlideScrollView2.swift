import Cocoa

class ElasticSlideScrollView2:SlideView2,ElasticSlidableScrollable2{
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat] = Array(repeating: 0, count: 10)/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    override func scrollWheel(with event: NSEvent) {//you can probably remove this method and do it in base?"!?
        scroll(event)
    }
}

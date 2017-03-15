import Foundation

struct InterimScroll {
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat]/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    init(_ velocities:[CGFloat] = Array(repeating: 0, count: 10)) {
        self.velocities = velocities
    }
}

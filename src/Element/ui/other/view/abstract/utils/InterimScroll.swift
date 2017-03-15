import Foundation
/**
 * Temporary scroll values are stored here
 * Definition of interim: meanwhile, temporary, inbetween time
 * NOTE: supports both X and Y axis
 */
struct InterimScroll {
    var prevScrollingDelta:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat]/*represents the velocity resolution of the gesture movment*/
    //⚠️️ you may be able to remove progressvalue in the future. as it works differently now!=!=?
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    init(_ velocities:[CGFloat] = Array(repeating: 0, count: 10)) {
        self.velocities = velocities
    }
}

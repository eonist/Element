import Foundation
@testable import Utils
/**
 * This protocol exist because other that Lists may want to be Elastic scrollable, like A container of things
 */
protocol Elastic2:Displacable2{
    var mover:RubberBand?{get set}
    var prevScrollingDeltaY:CGFloat{get set}
    var velocities:[CGFloat]{get set}
    //⚠️️ you may be able to remove progressvalue in the future. as it works differently now!=!=?
    var progressValue:CGFloat?{get set}//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
}
extension Elastic2{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){//DIRECT TRANSMISSION 💥
        Swift.print("Elastic2.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
    }
}

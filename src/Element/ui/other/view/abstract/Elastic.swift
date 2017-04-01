import Foundation
@testable import Utils
/**
 * This protocol exist because other that Lists may want to be Elastic scrollable, like A container of things
 */
protocol Elastic:Containable {
    var mover:RubberBand?{get set}
    var prveScrollingDelta:CGFloat{get set}
    var prevScrollingDeltaY:CGFloat{get set}//rename to to: prevScrollingDelta 
    var velocities:[CGFloat]{get set}
    //⚠️️ you may be able to remove progressvalue in the future. as it works differently now!=!=?
    var progressValue:CGFloat?{get set}//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    var iterimScroll:InterimScroll{get set}
}
extension Elastic {
    var prveScrollingDelta:CGFloat{get{return prevScrollingDeltaY}set{prevScrollingDeltaY = newValue}}
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){//DIRECT TRANSMISSION 💥
        Swift.print("Elastic2.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        //the bellow var may not be need to be set
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
    }
    /*DEPRECATED,Legacy support*/
    var prevScrollingDeltaY:CGFloat{get{return iterimScroll.prevScrollingDelta}set{iterimScroll.prevScrollingDelta = newValue}}
    var progressValue:CGFloat?{get{return iterimScroll.progressValue}set{iterimScroll.progressValue = newValue}}
    var velocities:[CGFloat]{get{return iterimScroll.velocities}set{iterimScroll.velocities = newValue}}
}

import Cocoa

protocol IRBSliderList {
    var mover:RubberBand{get}
    var prevScrollingDeltaY:CGFloat{get set}
    var velocities:Array<CGFloat>{get set}
}
extension IRBSliderList{
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    func scroll(theEvent:NSEvent) {
        //Swift.print("RBScrollController.scrollWheel()")
        if(theEvent.phase != NSEventPhase.None){
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
        case NSEventPhase.Changed:onScrollWheelChange(theEvent)/*fires everytime there is direct scrollWheel gesture movment.*/
        case NSEventPhase.MayBegin:onScrollWheelEnter()/*can be used to detect if two fingers are touching the trackpad*/
        case NSEventPhase.Began:onScrollWheelEnter()/*the mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
        case NSEventPhase.Ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
        case NSEventPhase.Cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
        case NSEventPhase.None:break;
        default:break;
        }
    }
}
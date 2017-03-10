import Cocoa

protocol Scrollable2:Displacable2{
    func onScrollWheelChange(_ event:String)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

extension Scrollable2{
    var interval:CGFloat{return floor(itemsHeight - height)/itemHeight}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
    var progress:CGFloat{return SliderParser.progress(lableContainer!.y, height, itemsHeight)}
    /**
     * IMPORTANT: as long as this method doesnt recide in the baseClass it can be reached with protocol ambiguity
     * NOTE: You can use the event.deviceDeltaY to check which direction the gesture is moving in
     * NOTE: These methods later call methods that are overridable.
     */
    func scroll(_ theEvent:NSEvent) {
        Swift.print("IRBScrollable.scrollWheel()")
        if(theEvent.phase != []){//swift 3 update, was -> NSEventPhase.none
            //Swift.print("theEvent.phase: " + "\(theEvent.phase)")
        }
        switch theEvent.phase{
            case NSEventPhase.changed:onScrollWheelChange(theEvent)/*Fires everytime there is direct scrollWheel gesture movment.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            case []:break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
    }
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("📜 Scrollable.onScrollWheelChange: \(event)")
        setProgress(0.5)/*<-faux progress, its caluclated via delta noramlly*/
    }
    /*func setProgress(_ progress:CGFloat){
     Swift.print("📜 Scrollable.setProgress(\(progress)) move the lableContainer.y up and down")
     }*/
    func onScrollWheelEnter() {
        Swift.print("📜 Scrollable.onScrollWheelEnter")
    }
    func onScrollWheelExit() {
        Swift.print("📜 Scrollable.onScrollWheelExit")
    }
}

import Cocoa
@testable import Element
@testable import Utils

protocol Scrollable2:Containable2 {
     func onScrollWheelChange(_ event:NSEvent)
     func onScrollWheelEnter()
     func onScrollWheelExit()
}
extension ContainerView2{//use some where magic? see your notes on this
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
        //Swift.print("ScrollVList.scrollWheel")
        if(self is Scrollable2){
            (self as! Scrollable2).scroll(event)
        }
        //super.scrollWheel(with: event)
    }
}

extension Scrollable2{
    func scroll(_ event:NSEvent){
        //Swift.print("Scrollable2.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            
            //if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
            
            case NSEventPhase.changed:onScrollWheelChange(event)/*Direct scroll*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit()//always exits with event with no delta
            case NSEventPhase.cancelled:onScrollWheelExit()//always exits with event with no delta
            /*Toggeling the bellow on and off can break things*/
            case NSEventPhase(rawValue:0):onScrollWheelChange(event)/*this is the same as momentum aka inDirect scroll*/
            default:break;
        }
    }
     func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        //Swift.print("📜 Scrollable2.onScrollWheelChange: \(event.type)")
     }
     func onScrollWheelEnter() {
        //Swift.print("📜 Scrollable2.onScrollWheelEnter()")
     }
     func onScrollWheelExit() {
        //Swift.print("📜 Scrollable2.onScrollWheelExit()")
     }/**/
}

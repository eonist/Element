import Cocoa

class ScrollController:EventSender {
    init(_ callBack:(CGFloat)->Void,_ frame:CGRect, _ itemRect:CGRect){
        
        super.init()
        
    }
    override func scrollWheel(theEvent:NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        let scrollAmount:CGFloat = (theEvent.deltaY/30)/sliderInterval!/*_scrollBar.interval*/
        var currentScroll:CGFloat = slider!.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)/*clamps the num between 0 and 1*/
        
        if(theEvent.momentumPhase == NSEventPhase.Ended){
            //Swift.print("the scroll motion ended")
            super.onEvent(ScrollWheelEvent(ScrollWheelEvent.exit,self))
        }else if(theEvent.momentumPhase == NSEventPhase.Began){//include may begin here
            //Swift.print("the scroll motion began")
            super.onEvent(ScrollWheelEvent(ScrollWheelEvent.enter,self))
        }
        super.scrollWheel(theEvent)
    }
}

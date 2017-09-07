import Cocoa
@testable import Utils
//⚠️️ rename to ScrollerHandler
class ScrollHandler:ProgressHandler,Scrollable5{
//    var scrollable:Scrollable5 {get{return progressable as! Scrollable5}}
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
//        Swift.print("ScrollHandler.scroll")
        //Swift.print("event.momentumPhase: " + "\(event.momentumPhase)")
        //Swift.print("event.phase: " + "\(event.phase)")
//        Swift.print("ScrollHandler.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
        case NSEvent.Phase.changed/*4*/:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
        case NSEvent.Phase.mayBegin/*32*/:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
        case NSEvent.Phase.began/*1*/:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
        case NSEvent.Phase.ended/*8*/:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
        case NSEvent.Phase.cancelled/*16*/:onScrollWheelCancelled()/*this trigers if the scrollWhell gestures goes off the trackpad etc, and also if there was no movement and you release again*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/**//*onScrollWheelChange(event)*/_ = "";/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            /*case NSEventPhase.stationary: 2*/
        default:break;
        }
        switch event.momentumPhase{
        case NSEvent.Phase.began:
            //Swift.print("⚠️️ NSMomentumEventPhase.began event.scrollingDelta: " + "\(event.scrollingDelta)")
            onScrollWheelMomentumBegan(event);//this happens when the momentum starts
        case NSEvent.Phase.changed:onInDirectScrollWheelChange(event);
        case NSEvent.Phase.ended:onScrollWheelMomentumEnded();
        default:break;
        }
        //super.scrollWheel(with:event)
    }
    func onScrollWheelChange(_ event:NSEvent){
//        Swift.print("ScrollHandler.onScrollWheelChange()")
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)//let progress:CGFloat = SliderParser.progress(event.delta, maskSize, contentSize).y
        setProgress(progressVal)
    }
    func onInDirectScrollWheelChange(_ event:NSEvent){
        onScrollWheelChange(event)//is this really needed?
    }
    func onScrollWheelEnter(){
        ScrollFastList3.startTime = NSDate()
        ScrollFastList3.numOfEvents = 0//reset
        Swift.print("ScrollHandler.onScrollWheelEnter()")
    }
    func onScrollWheelExit(){
        let secs:CGFloat = abs(ScrollFastList3.startTime!.timeIntervalSinceNow).cgFloat
        Swift.print("secs: " + "\(secs)")
        let numOfEvents:CGFloat = ScrollFastList3.numOfEvents!.cgFloat
        Swift.print("numOfEvents: " + "\(numOfEvents)")
        let eventsPerSeconds:CGFloat = numOfEvents/secs
        Swift.print("eventsPerSeconds: " + "\(eventsPerSeconds)")
        
        Swift.print("ScrollHandler.onScrollWheelExit()")
    }
    func onScrollWheelMomentumEnded(){Swift.print("Scrollable3.onScrollWheelMomentumEnded")}
    func onScrollWheelCancelled(){Swift.print("Scrollable3.onScrollWheelCancelled")}
    func onScrollWheelMomentumBegan(_ event:NSEvent){Swift.print("Scrollable3.onScrollWheelMomentumBegan")}
}

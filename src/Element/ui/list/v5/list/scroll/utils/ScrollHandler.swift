import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ rename to ScrollerHandler
 * We have Handlers so that we can reuse the same code in ScrollerList and ScrollerView
 */
class ScrollHandler:ProgressHandler,Scrollable5{
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
        //Swift.print("event.phase: " + "\(event.phase)" + "event.momentumPhase: " + "\(event.momentumPhase)")
//        Swift.print("ScrollHandler.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
        case .changed/*4*/:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
        case .mayBegin/*32*/:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
        case .began/*1*/:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
        case .ended/*8*/:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
        case .cancelled/*16*/:onScrollWheelCancelled()/*this trigers if the scrollWhell gestures goes off the trackpad etc, and also if there was no movement and you release again*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/**//*onScrollWheelChange(event)*/_ = "";/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            /*case NSEventPhase.stationary: 2*/
        default:break;
        }
        switch event.momentumPhase{
        case .began:
            //Swift.print("⚠️️ NSMomentumEventPhase.began event.scrollingDelta: " + "\(event.scrollingDelta)")
            onScrollWheelMomentumBegan(event);//this happens when the momentum starts
        case .changed:onInDirectScrollWheelChange(event);
        case .ended:onScrollWheelMomentumEnded();
        default:break;
        }
        //super.scrollWheel(with:event)
    }
    /**
     * NOTE: as a temp work-around you can do: if event.phase == NSEvent.Phase.changed {do direct stuff here}
     */
    func onScrollWheelChange(_ event:NSEvent){//rename to onDirectScrollwheel
//        Swift.print("ScrollHandler.onScrollWheelChange()")
        let sliderProgress:CGPoint = progress
//        Swift.print("🍊 sliderProgress: " + "\(sliderProgress)")
//        Swift.print("interval: " + "\(interval)")
//        Swift.print("event.delta: " + "\(event.delta)")
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, sliderProgress)//let progress:CGFloat = SliderParser.progress(event.delta, maskSize, contentSize).y
//        Swift.print(" progressVal: " + "\(progressVal)")
//        Swift.print("contentSize: " + "\(contentSize)")
        setProgress(progressVal)
    }
    func onInDirectScrollWheelChange(_ event:NSEvent){
        onScrollWheelChange(event)//is this really needed?, sort of defeats the purpous eof having 2 scrollwheel change methods
    }
    func onScrollWheelEnter(){
        ScrollFastList3.startTime = NSDate()//This is related to performance testing
        ScrollFastList3.numOfEvents = 0//reset
//        Swift.print("ScrollHandler.onScrollWheelEnter()")
    }
    func onScrollWheelExit(){
        let secs:CGFloat = abs(ScrollFastList3.startTime!.timeIntervalSinceNow).cgFloat//This is related to performance testing
//        Swift.print("secs: " + "\(secs)")
        let numOfEvents:CGFloat = ScrollFastList3.numOfEvents!.cgFloat
//        Swift.print("numOfEvents: " + "\(numOfEvents)")
        let eventsPerSeconds:CGFloat = numOfEvents/secs
//        Swift.print("eventsPerSeconds: " + "\(eventsPerSeconds)")
//        Swift.print("ScrollHandler.onScrollWheelExit()")
    }
    func onScrollWheelMomentumEnded(){/*Swift.print("Scrollable3.onScrollWheelMomentumEnded")*/}
    func onScrollWheelCancelled(){/*Swift.print("Scrollable3.onScrollWheelCancelled")*/}
    func onScrollWheelMomentumBegan(_ event:NSEvent){/*Swift.print("Scrollable3.onScrollWheelMomentumBegan")*/}
}

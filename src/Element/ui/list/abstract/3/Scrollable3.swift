import Cocoa
@testable import Utils
@testable import Element

protocol Scrollable3:Progressable3 {
    func onScrollWheelChange(_ event:NSEvent)/*Fires onle while direct scroll, not momentum*/
    func onScrollWheelEnter()/*fires while there still is momentum aka indirect scroll*/
    func onScrollWheelExit()/*This happens after there has been panning and the touches release*/
    func onScrollWheelCancelled()/*This happens when there has been no panning, just 2 finger touch and release with out moving around*/
    func onInDirectScrollWheelChange(_ event:NSEvent)//rename to onScrollWheelMomentumChange
    /*Momentum*/
    func onScrollWheelMomentumEnded()
    func onScrollWheelMomentumBegan(_ event:NSEvent)/*This happens right after touch release and there is enough velocity that momentum is engaged, we forward the event because we might need the scrollingDelta for velocity*/
}
extension Scrollable3{
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
        //Swift.print("event.momentumPhase: " + "\(event.momentumPhase)")
        //Swift.print("event.phase: " + "\(event.phase)")
        //Swift.print("Scrollable3.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            case NSEventPhase.changed/*4*/:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin/*32*/:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began/*1*/:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended/*8*/:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled/*16*/:onScrollWheelCancelled()/*this trigers if the scrollWhell gestures goes off the trackpad etc, and also if there was no movement and you release again*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/**//*onScrollWheelChange(event)*/_ = "";/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            /*case NSEventPhase.stationary: 2*/
            default:break;
        }
        switch event.momentumPhase{
            case NSEventPhase.began:
                //Swift.print("⚠️️ NSMomentumEventPhase.began event.scrollingDelta: " + "\(event.scrollingDelta)")
                onScrollWheelMomentumBegan(event);//this happens when the momentum starts
            case NSEventPhase.changed:onInDirectScrollWheelChange(event);
            case NSEventPhase.ended:onScrollWheelMomentumEnded();
            default:break;
        } 
        //super.scrollWheel(with:event)
    }
    func onScrollWheelChange(_ event:NSEvent){
        //Swift.print("Scrollable3.onScrollWheelChange()")
        //let progress:CGFloat = SliderParser.progress(event.delta, maskSize, contentSize).y
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        setProgress(progressVal)
    }
    func onInDirectScrollWheelChange(_ event:NSEvent){
        onScrollWheelChange(event)//is this really needed?
    }
    func onScrollWheelEnter(){Swift.print("Scrollable3.onScrollWheelEnter()")}
    func onScrollWheelExit(){Swift.print("Scrollable3.onScrollWheelExit()")}
    func onScrollWheelMomentumEnded(){Swift.print("Scrollable3.onScrollWheelMomentumEnded")}
    func onScrollWheelCancelled(){Swift.print("Scrollable3.onScrollWheelCancelled")}
    func onScrollWheelMomentumBegan(_ event:NSEvent){Swift.print("Scrollable3.onScrollWheelMomentumBegan")}
}
extension ContainerView3 {//private maybe?
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
       // Swift.print("ContainerView3.scrollWheel")
        if(self is ElasticSlidableScrollableFastListable3){
            (self as! ElasticSlidableScrollableFastListable3).scroll(event)
        }else if(self is ElasticSlidableScrollable3){
            (self as! ElasticSlidableScrollable3).scroll(event)
        }else if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }else{
            fatalError("type not supported")
        }/*else if(self is Slidable3){
         if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
         (self as! Slidable3).showSlider()
         }
         }*/
        super.scrollWheel(with: event)
    }
}

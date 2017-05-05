import Cocoa
@testable import Element
@testable import Utils

protocol ElasticScrollable2:Elastic2,Scrollable2 {
    func setProgress(_ value:CGFloat)
}
extension ElasticScrollable2{
    
    /*func setProgress(_ value:CGFloat){
        contentContainer!.frame.x = value
     }*/
     func onScrollWheelChange(_ event:NSEvent){
        //Swift.print("👻📜 (ElasticScrollable2).onScrollWheelChange event.scrollingDeltaX: \(event.scrollingDeltaX) event.deltaX: \(event.deltaX)")
        iterimScroll.prevScrollingDelta = event.scrollingDeltaX
        _ = iterimScroll.velocities.shiftAppend(event.scrollingDeltaX)
        mover!.value += event.scrollingDeltaX
        mover!.updatePosition()
        setProgress(mover!.result)
        /*⚠️️ temp fix for SnappyRubberBand support, move this into a new protocol extension*/
        /*let prevDir = (mover! as! SnappyRubberBand).prevDir
        var tempDir:CGFloat = 0
        let curDir = event.scrollingDeltaX
        if(curDir == 0){tempDir = prevDir}//use old value
        else if(curDir.isNegative){tempDir = -1}
        else if(curDir.isPositive){tempDir = 1}
        Swift.print("tempDir: " + "\(tempDir)")
        (mover! as! SnappyRubberBand).prevDir = tempDir*/
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
     func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable2).onScrollWheelEnter")
        //Swift.print("IRBScrollable.onScrollWheelDown")
        mover!.stop()
        mover!.hasStopped = true
        iterimScroll.prevScrollingDelta = 0
        mover!.isDirectlyManipulating = true
        iterimScroll.velocities = Array(repeating: 0, count: 10)/*reset*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
     func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable2).onScrollWheelExit")
        //Swift.print("iterimScroll.prevScrollingDelta: " + "\(iterimScroll.prevScrollingDelta)")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        mover!.hasStopped = false
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result
        
        //you need to record the last directional scroll, as the last changeEvent can actually be 0
        //continue here:
            //you need to record direction
            //and what was deltaX on the last change before exit. is it always 0?
        
        let prevDelta:CGFloat = iterimScroll.prevScrollingDelta
        if(abs(prevDelta) > 3){//must have more momentum than 3
            Swift.print("MOMENTUM")
            var velocity:CGFloat
            if(iterimScroll.prevScrollingDelta > 1.0){//TODO: merge < and > together, they are now the same
                Swift.print("> momentum")
                velocity = CGFloatParser.average(iterimScroll.velocities.filter{$0 != 0})//NumberParser.max()
            }/*Find the most positive velocity value*/
            else if(iterimScroll.prevScrollingDelta < -1.0){
                Swift.print("< momentum")
                velocity = CGFloatParser.average(iterimScroll.velocities.filter{$0 != 0})//NumberParser.min(iterimScroll.velocities)
            }/*Find the most negative velocity value*/
            else {
                velocity = 0
                Swift.print("0 momentum")
            }//The prevScrollingDelta is: either '-1' or '+1' which means that the scrollwheel is stationary
            //Swift.print("iterimScroll.velocities: " + "\(iterimScroll.velocities)")
            Swift.print("exit: velocity: \(velocity)")
            mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            mover!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{// if(prevDelta == 0 || prevDelta == 1.0 || prevDelta == -1.0){
            Swift.print("STATIONARY")
            //the prev change event had zero momentum aka stationary
            mover!.velocity = 0
            mover!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
        }/*else{
         fatalError("should not be possible")
         }*/
        /*X*/
        //if(iterimScroll.prevScrollingDelta != 1.0 && iterimScroll.prevScrollingDelta != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary, or in other words: -1 or 1 means that the scrollwheel is stationary*/
        
        //}else{/**/
            //
        //}
    }
}

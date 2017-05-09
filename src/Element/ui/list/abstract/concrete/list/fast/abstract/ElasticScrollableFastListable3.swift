import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ To solve the lag problem when scrolling really fast you have to simply tap into the FPS ticker and setProgress on a tick not via MouseInteraction tick as this tick is beyond 60FPS (this bug is also in macOS so maybe its not imp atm)
 */
protocol ElasticScrollableFastListable3:FastListable3,ElasticScrollable3 {
    var rbContainer:Container?{get}
}
extension ElasticScrollableFastListable3{
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//override to cancel out the event,move this more centerally, or remove
    func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        //Swift.print("event.type: " + "\(event.phase)")
        //Swift.print("ElasticScrollableFastListable3.onScrollWheelChange : \(event.type) event.delta: \(event.delta)")
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup!.result
        //(self as ElasticScrollableFastListable3).setProgress(p)
        setProgressVal(p.x,.hor)
        setProgressVal(p.y,.ver)
    }
    /**
     * PARAM value: is the final y value for the lableContainer
     * ⚠️️ Do not use scalar value here (0-1) well you know...
     */
    func setProgressVal(_ value:CGFloat,_ dir:Dir){
        //Swift.print("👻🏂📜🐎 ElasticScrollableFastListable.setProgress(\(value))")
        //Swift.print("value: " + "\(value)")
        var progressValue:CGFloat?//new
        let contentSide:CGFloat = contentSize[dir]//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if(contentSide < maskSize[dir]){//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / maskSize[dir]
            let val = progressValue! * maskSize[dir]
            posContainer(rbContainer!,dir,val)
        }else{
            progressValue = value / -(contentSide - maskSize[dir])/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            (self as Scrollable3).setProgress(progress,dir)/*moves the lableContainer up and down*/
            (self as FastListable3).setProgress(progress)/*Updates the positions of the FastListItems*/
            //
            let sliderProgress = ElasticUtils.progress(value,contentSide,maskSize[dir])//doing some double calculations here
            /*finds the values that is outside 0 and 1*/
            if(sliderProgress < 0){//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let v1 = maskSize[dir] * -sliderProgress
                posContainer(rbContainer!,dir,v1)/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if(sliderProgress > 1){
                let v2 = maskSize[dir] * -(sliderProgress-1)
                posContainer(rbContainer!,dir,v2)
            }else{
                posContainer(rbContainer!,dir,0)/*default position*/
            }
        }
        //Swift.print("rbContainer!.point[dir]: " + "\(rbContainer!.point[dir])")
        //Swift.print("contentContainer.point[dir]: " + "\(contentContainer!.point[dir])")
    }
}
extension ElasticScrollableFastListable3{
    func posContainer(_ rbContainer:Container,_ dir:Dir,_ value:CGFloat){/*Temp*/
        disableAnim {rbContainer.layer?.position[dir] = value}/*default position*/
    }
}

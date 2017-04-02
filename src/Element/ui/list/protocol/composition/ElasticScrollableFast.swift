import Cocoa
@testable import Element
@testable import Utils

protocol ElasticScrollableFast:IFastList,ElasticScrollable {
    var rbContainer:Container?{get set}
    func frameTick(_ value:CGFloat)
}
extension ElasticScrollableFast{
    /**
     * ⚠️️⚠️️⚠️️SUPER IMPORTANT CONCEPT⚠️️⚠️️⚠️️: methods that are called from shallow can overide downstream in POP
     */
    func scroll(_ event:NSEvent) {
        Swift.print("👻🏂📜🐎 ElasticSlidableScrollableFast.scroll()")
        (self as Scrollable).scroll(event)//👈 calls from shallow can overide downstream
        /*the following must be after the call above or else the thumb is hidden because of anim.end*/
        if(event.phase == NSEventPhase.changed){
            if(mover!.isDirectlyManipulating){
                //also manipulates slider, but only on directTransmission, as mover calls setProgress from shallow in indirectTransmission
                setProgress(mover!.result)//👈NEW, this migth need to be inSide scrollWheel call, as it needs to be shallow to reach inside setProgress in ElasticFastList.setProgress, but maybe not, To be continued
            }
        }
    }
    /**
     * PARAM value: is the final y value for the lableContainer
     */
    func setProgress(_ value:CGFloat){
        Swift.print("👻🏂📜🐎 ElasticSlidableScrollableFast.setProgress(\(value))")
        //Swift.print("value: " + "\(value)")
        let contentSide:CGFloat = contentSize[dir]//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if(contentSide < maskSize[dir]){//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / maskSize[dir]
            //Swift.print("progressValue: " + "\(progressValue)")
            let val = progressValue! * maskSize[dir]
            //Swift.print("y: " + "\(y)")
            rbContainer!.point[dir] = val
        }else{
            progressValue = value / -(contentSide - maskSize[dir])/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            (self as Scrollable).setProgress(progress)/*moves the lableContainer up and down*/
            (self as IFastList).setProgress(progress)
            //
            let sliderProgress = ElasticUtils.progress(value,contentSide,maskSize[dir])//doing some double calculations here
            /*finds the values that is outside 0 and 1*/
            if(sliderProgress < 0){//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let v1 = maskSize[dir] * -sliderProgress
                rbContainer!.point[dir] = v1/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if(sliderProgress > 1){
                let v2 = maskSize[dir] * -(sliderProgress-1)
                rbContainer!.point[dir] = v2
            }else{
                rbContainer!.point[dir] = 0/*default position*/
            }
        }
    }
}

import Cocoa
@testable import Utils
protocol ElasticSlidableScrollableFast:IFastList2,ElasticScrollable, Slidable {
    var rbContainer:Container?{get set}
    func frameTick(_ value:CGFloat)
}
extension ElasticSlidableScrollableFast{
    /**
     * ⚠️️⚠️️⚠️️SUPER IMPORTANT CONCEPT⚠️️⚠️️⚠️️: methods that are called from shallow can overide downstream in POP
     */
    func scroll(_ event: NSEvent) {
        Swift.print("👻🏂📜🐎 ElasticSlidableScrollableFast.scroll()")
        (self as Scrollable).scroll(event)//👈 calls from shallow can overide downstream
        /*the following must be after the call above or else the thumb is hidden because of anim.end*/
        if(event.phase == NSEventPhase.changed){
            if(mover!.isDirectlyManipulating){
                //also manipulates slider, but only on directTransmission, as mover calls setProgress from shallow in indirectTransmission
                setProgress(mover!.result)//👈NEW, this migth need to be inSide scrollWheel call, as it needs to be shallow to reach inside setProgress in ElasticFastList.setProgress, but maybe not, To be continued
            }
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
    }
    /**
     * PARAM value: is the final y value for the lableContainer
     */
    func setProgress(_ value:CGFloat){
        Swift.print("👻🏂📜🐎 ElasticSlidableScrollableFast.setProgress(\(value))")
        //Swift.print("value: " + "\(value)")
        let itemsHeight = self.itemsHeight//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if(itemsHeight < height){//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / height
            //Swift.print("progressValue: " + "\(progressValue)")
            let y = progressValue! * height
            //Swift.print("y: " + "\(y)")
            rbContainer!.y = y
        }else{
            progressValue = value /  -(itemsHeight - height)/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            (self as Scrollable).setProgress(progress)/*moves the lableContainer up and down*/
            (self as IFastList2).setProgress(progress)
            //
            let sliderProgress = ElasticUtils.progress(value,itemsHeight,height)//doing some double calculations here
            slider!.setProgressValue(sliderProgress)//<- scalar value 0-1
            /*finds the values that is outside 0 and 1*/
            //Swift.print("progressValue!: " + "\(progressValue!)")
            if(sliderProgress < 0){//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let y1 = height * -sliderProgress
                //Swift.print("y1: " + "\(y1)")
                rbContainer!.y = y1/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if(sliderProgress > 1){
                let y2 = height * -(sliderProgress-1)
                //Swift.print("y2: " + "\(y2)")
                rbContainer!.y = y2
            }else{
                rbContainer!.y = 0/*default position*/
            }
        }
    }
}

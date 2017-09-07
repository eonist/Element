import Cocoa
@testable import Utils

class ElasticSliderScrollerFastList5:FastList5,Elastic5,Slidable5 {
    lazy var hSlider:Slider = self.createHSlider
    lazy var vSlider:Slider = self.createVSlider
    lazy var moverGroup:MoverGroup = self.moverGrp
    lazy var rbContainer:Container = self.createRBContainer/*Needed for the overshot animation*/
    override func onEvent(_ event:Event) {
        if(event.type == AnimEvent.stopped){
            let dir:Dir = event.origin === moverGroup.yMover ? .ver : .hor
            hideSlider(dir)/*Hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
    
    //move the bellow into the eventHandler ⚠️️
    
    
    /**
     * PARAM value: is the final y value for the lableContainer
     * ⚠️️ Do not use scalar value here (0-1) well you know...
     */

    func setProgressValue(_ value:CGFloat, _ dir:Dir) {/*Gets calls from MoverGroup*/
        //Swift.print("ElasticSlidableScrollableFastListable3.setProgressValue(val,dir)")
        //Swift.print("👻🏂📜🐎 ElasticScrollableFastListable.setProgress(\(value))")
        //Swift.print("value: " + "\(value)")
        var progressValue:CGFloat?//new
        let contentSide:CGFloat = contentSize[dir]//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if contentSide < maskSize[dir] {//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / maskSize[dir]
            let val = progressValue! * maskSize[dir]
            posContainer(rbContainer,dir,val)
        }else{
            progressValue = value / -(contentSide - maskSize[dir])/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            //(self as! Scrollable5).setProgress(progress,dir)/*moves the lableContainer up and down*/
            super.setProgress(progress)/*Updates the positions of the FastListItems*/
            //
            let sliderProgress = ElasticUtils.progress(value,contentSide,maskSize[dir])//doing some double calculations here
            /*finds the values that is outside 0 and 1*/
            if sliderProgress < 0 {//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let v1 = maskSize[dir] * -sliderProgress
                posContainer(rbContainer,dir,v1)/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if sliderProgress > 1 {
                let v2 = maskSize[dir] * -(sliderProgress-1)
                posContainer(rbContainer,dir,v2)
            }else{
                posContainer(rbContainer,dir,0)/*default position*/
            }
        }
        //Swift.print("rbContainer!.point[dir]: " + "\(rbContainer!.point[dir])")
        //Swift.print("contentContainer.point[dir]: " + "\(contentContainer!.point[dir])")
        
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])//doing some double calculations here
        slider(dir).setProgressValue(sliderProgress)//temp fix
    }
    func scroll(_ event: NSEvent) {
        //Swift.print("ElasticSlidableScrollableFastListable3.scroll")
        //super.scroll(event)//forward the event
        switch event.phase{
        case /*NSEvent.Phase*/.changed://Direct scroll, ⚠️️That you need a hock here is not that great
            let sliderProgress:CGPoint = ElasticUtils.progress(moverGroup.result,contentSize,maskSize)
            (self as Slidable5).setProgress(sliderProgress)/*moves the sliders*/
        case /*NSEvent.Phase*/.mayBegin, /*NSEvent.Phase*/.began:/*same as onScrollWheelEnter()*/
            showSlider()
        case /*NSEvent.Phase*/.ended://same as onScrollWheelExit()
            hideSlider()
        default:break;
        }
        if(event.momentumPhase == NSEvent.Phase.began){//simulates: onScrollWheelMomentumBegan()
            showSlider()//cancels out the hide call when onScrollWheelExit is called when you release after pan gesture
        }
    }
    func onScrollWheelCancelled() {
        Swift.print("ElasticSlidableScrollable3.onScrollWheelCancelled")
        hideSlider()
    }
}



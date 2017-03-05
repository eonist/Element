import Foundation


//you probably also need Scrollable
protocol IRBScrollableSlidable:ISlidable,IRBScrollable{
    
}

//Convenience, almost like a typalias
extension IRBScrollableSlidable{
    /**
     * EventHandler for the Slider change event
     */
    func onSliderChange(_ sliderEvent:SliderEvent){
        SlideableUtils.scrollTo(self,sliderEvent.progress)
        mover!.value = lableContainer!.frame.y
    }
    func scrollWheelExit() {defaultScrollWheelEntersScrollWheelExit()}
    func scrollWheelEnter() {defaultScrollWheelEnter()}
    func scrollWheelExitedAndIsStationary(){defaultScrollWheelEnterScrollWheelExitedAndIsStationary()}
    func scrollAnimStopped(){defaultScrollAnimStopped()}
    /**
     * When two fingers touches the track-pad this method is called
     * NOTE: this method is called from: onScrollWheelEnter
     */
    func defaultScrollWheelEnter(){//2. spring to refreshStatePosition
        //Swift.print("RBSliderFastList.scrollWheelEnter()" + "\(progressValue)")
        if(itemsHeight >= height){slider!.thumb!.fadeIn()}/*fades in the slider*/
    }
    /**
     * NOTE: This method is called from onScrollWheelExit
     */
    func defaultScrollWheelEntersScrollWheelExit(){}
    func defaultScrollWheelEnterScrollWheelExitedAndIsStationary(){
        if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}/*only fade out if the state is none, aka not over*/
    }
    func defaultScrollAnimStopped(){
        slider!.thumb!.fadeOut()
    }
}


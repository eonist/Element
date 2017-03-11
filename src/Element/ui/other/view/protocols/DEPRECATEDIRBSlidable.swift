import Foundation
@testable import Utils
/**
 * For Elements that are both scrollable and slideable
 */
protocol DEPRECATEDIRBSlidable: DEPRECATEDIRBScrollable, DEPRECATEDISlidable {//Convenience, almost like a typalias
    //  I think you can do: typealias IRBSlidable = IRBScrollable & ISlidable isntead of the above?!?
}

//The bellow can probably be moved into the SlidableExtension. as it also applies to ISlidable

extension DEPRECATEDIRBSlidable {
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){//DIRECT TRANSMISSION 💥
        //Swift.print("IRBSlidable.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
        slider!.setProgressValue(progressValue!)
        
    }
    /**
     * EventHandler for the Slider change event
     */
    func onSliderChange(_ sliderEvent:SliderEvent){
        ScrollableUtils.scrollTo(self,sliderEvent.progress)
        //mover!.value = lableContainer!.frame.y
    }
    //im not sure the default scheme was needed, remove later if unused
    func scrollWheelExit() {defaultScrollWheelEntersScrollWheelExit()}
    func scrollWheelEnter() {defaultScrollWheelEnter()}
    func scrollWheelExitedAndIsStationary(){defaultScrollWheelEnterScrollWheelExitedAndIsStationary()}
    func scrollAnimStopped(){defaultScrollAnimStopped()}
    /**
     * When two fingers touches the track-pad this method is called
     * NOTE: this method is called from: onScrollWheelEnter
     */
    func defaultScrollWheelEnter(){//2. spring to refreshStatePosition
        Swift.print("IRBSlidable.defaultScrollWheelEnter()" + "\(progressValue)")
        if(itemsHeight >= height){slider!.thumb!.fadeIn()}/*fades in the slider*/
    }
    /**
     * NOTE: This method is called from onScrollWheelExit
     */
    func defaultScrollWheelEntersScrollWheelExit(){}
    func defaultScrollWheelEnterScrollWheelExitedAndIsStationary(){
        Swift.print("IRBSlidable.defaultScrollWheelEnterScrollWheelExitedAndIsStationary()")
        if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}/*only fade out if the state is none, aka not over*/
    }
    func defaultScrollAnimStopped(){
        Swift.print("IRBSlidable.defaultScrollAnimStopped")
        slider!.thumb!.fadeOut()
    }
}

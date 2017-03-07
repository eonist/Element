import Foundation
@testable import Utils
/**
 * For Elements that are both scrollable and slideable
 * //TODO: rename to RBSlidable, as Slideable is scrollable
 */
protocol IRBScrollableSlidable:IRBScrollable,ISlidable{//Convenience, almost like a typalias
}

//The bellow can probably be moved into the SlidableExtension. as it also applies to ISlidable

extension IRBScrollableSlidable{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){
        Swift.print("IRBScrollableSlidable.setProgress() value: " + "\(value)")
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


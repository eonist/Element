import Foundation

protocol IRBScrollableSlidable:class,ISlidable,IRBScrollable{}//Convenience, almost like a typalias
extension IRBScrollableSlidable{
    /**
     * When two fingers are touches the track-pad this method is called
     */
    func scrollWheelEnter(){//2. spring to refreshStatePosition
        //Swift.print("RBSliderFastList.scrollWheelEnter()" + "\(progressValue)")
        if(itemsHeight >= height){slider!.thumb!.fadeIn()}/*fades in the slider*/
    }
    func scrollWheelExit(){}
    func scrollWheelExitedAndIsStationary(){
        if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}/*only fade out if the state is none, aka not over*/
    }
    func scrollAnimStopped(){
        slider!.thumb!.fadeOut()
    }
}


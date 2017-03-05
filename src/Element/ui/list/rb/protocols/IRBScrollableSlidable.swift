import Foundation

protocol IRBScrollableSlidable:class,ISlidable,IRBScrollable{}//Convenience, almost like a typalias
extension IRBScrollableSlidable{
    func scrollWheelEnter(){
        slider!.thumb!.fadeIn()
    }
    func scrollWheelExit(){}
    func scrollWheelExitedAndIsStationary(){
        if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}
    }
    func scrollAnimStopped(){
        slider!.thumb!.fadeOut()
    }
}

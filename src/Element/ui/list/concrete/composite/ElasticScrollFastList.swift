import Foundation
@testable import Utils
@testable import Element

class ElasticScrollFastList:FastList, ElasticScrollFast {
    /*RubberBand*/
    var mover:RubberBand?
    var iterimScroll:InterimScroll = InterimScroll()
    /*rbContainer*/
    var rbContainer:Container?/*needed for the overshot animation*/
    override func resolveSkin() {
        super.resolveSkin()
        /*rbContainer*/
        rbContainer = addSubView(Container(width,height,self,"rb"))
        rbContainer!.addSubview(lableContainer!)//add lable Container inside rbContainer
        lableContainer!.parent = rbContainer!
        /*RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect = CGRect(0,0,width,itemsHeight)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,frameTick/*👈important*/,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    }
    func frameTick(_ value:CGFloat){//real value
        setProgress(value)
    }
}

import Cocoa
@testable import Utils
@testable import Element

class ElasticScrollFastList:FastList, ElasticScrollableFast {
    /*RubberBand*/
    var mover:RubberBand?
    var iterimScroll:InterimScroll = InterimScroll()
    /*rbContainer*/
    var rbContainer:Container?/*needed for the overshot animation*/
    override func resolveSkin() {
        super.resolveSkin()
        /*rbContainer*/
        rbContainer = addSubView(Container(w,h,self,"rb"))
        rbContainer!.addSubview(lableContainer!)//add lable Container inside rbContainer
        lableContainer!.parent = rbContainer!
        createMover()
    }
    func createMover(){
        /*RubberBand*/
        let frame:RubberBand.Frame = (min:0,len:maskSize[dir])//CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect:RubberBand.Frame = (min:0,len:contentSize[dir])/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand.init(Animation.sharedInstance, setProgress, frame, itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    }
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("ElasticSlideScrollFastList.scrollWheel()")
        (self as ElasticScrollableFast).scroll(event)
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, mover!)){
            Swift.print("ElasticScrollFastList.anim stopped")
        }
        super.onEvent(event)
    }
}

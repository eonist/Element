import Cocoa
@testable import Utils

class ElasticSlideScrollFastList:SlideFastList,ElasticSlidableScrollableFast {
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
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        Swift.print("ElasticSlideScrollFastList.scrollWheel()")
        (self as ElasticSlidableScrollableFast).scroll(event)
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, mover!)){
            Swift.print("anim stopped")
            hideSlider()/*hides the slider when bounce back anim stopps*/
        }else if(event === (SliderEvent.change,slider!)){
            mover!.value = lableContainer!.frame.y//quick fix, ⚠️️⚠️️⚠️️TODO:  move into onSliderEvent in Slidable, and in ElasticSlidableScrollable
        }
        super.onEvent(event)
    }
}

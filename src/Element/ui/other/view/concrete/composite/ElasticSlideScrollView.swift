import Cocoa
@testable import Utils
/**
 * Might be better to not extend SlideView2
 */
class ElasticSlideScrollView: SlideView, ElasticSlidableScrollable {
    var mover:RubberBand?
    var iterimScroll:InterimScroll = InterimScroll()
    override func resolveSkin() {
        super.resolveSkin()
        /*RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect = CGRect(0,0,width,itemsHeight)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress/*👈important*/,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    }
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event: NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("ElasticSlideScrollView2.scrollWheel()")
        scroll(event)
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

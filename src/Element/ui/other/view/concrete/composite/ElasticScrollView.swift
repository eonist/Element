import Cocoa
@testable import Utils
/**
 * NOTE: this Method is totally academic, can be usefull for UI where you dont want or need slider. 
 */

class ElasticScrollView:ContainerView,ElasticScrollable {
    /*RubberBand*/
    var mover:RubberBand?
    var iterimScroll
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
    override func scrollWheel(with event: NSEvent) {
        Swift.print("👻📜.ScrollWheel")
        scroll(event)
        //TODO: you want to pass the scrollWheel method on here ⚠️️ NS up hirarchy may need it
    }
}

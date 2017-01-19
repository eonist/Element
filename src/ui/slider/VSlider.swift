import Cocoa
@testable import Utils
/**
 * VSlider is a simple vertical slider
 * NOTE: the reason we have two sliders instead of 1 is because otherwise the math and variable naming scheme becomes too complex (same goes for the idea of extending a Slider class)
 * NOTE: the overshot part is to support "the-RubberBand-list-look"
 * TODO: consider having thumbWidth and thumbHeight, its just easier to understand
 * TODO: rename thumbHeight to thumbWidth or?
 * TODO: remove refs to frame. you can use width and height directly
 * TODO: onSkinDown, onSkinUp ?
 * TODO: Some extra asserts were added to HSlider for mouse up and down etc. consider adding them here aswell if bugs occure
 */
class VSlider:Element{
    var thumb:Thumb?
    var leftMouseDraggedEventListener:Any?//TODO: rename to leftMouseDraggedEventListener or draggedEventListner
    var progress:CGFloat/*0-1*/
    var tempThumbMouseY:CGFloat = 0
    var thumbHeight:CGFloat
    init(_ width:CGFloat, _ height:CGFloat,_ thumbHeight:CGFloat = NaN, _ progress:CGFloat = 0,_ parent:IElement? = nil, id:String? = nil){
        self.progress = progress
        self.thumbHeight = thumbHeight.isNaN ? width:thumbHeight// :TODO: explain in a comment what this does
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        //Swift.print("\(self.dynamicType)" + "resolveSkin(): ")
        super.resolveSkin()
        //skin.isInteractive = false// :TODO: explain why in a comment
        //skin.useHandCursor = false;// :TODO: explain why in a comment
        //Swift.print("width: " + "\(width)")
        //Swift.print("thumbHeight: " + "\(thumbHeight)")
        thumb = addSubView(Thumb(width, thumbHeight,false,self))
        setProgressValue(progress)// :TODO: explain why in a comment, because initially the thumb may be positioned wrongly  due to clear and float being none
    }
    func onThumbDown(){
        //Swift.print("\(self.dynamicType)"+".onThumbDown() ")
        tempThumbMouseY = thumb!.localPos().y
        //Swift.print("tempThumbMouseY: " + "\(tempThumbMouseY)")
        leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching:[.leftMouseDragged], handler:onThumbMove)/*we add a global mouse move event listener*/
    }
    func onThumbMove(event:NSEvent)-> NSEvent?{
        //Swift.print("\(self.dynamicType)"+".onThumbMove() " + "localPos: " + "\(event.localPos(self))")
        progress = Utils.progress(event.localPos(self).y, tempThumbMouseY, height/*<--this is the problem, dont use frame*/, thumbHeight)
        thumb!.y = Utils.thumbPosition(progress, height, thumbHeight)
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    func onThumbUp(){
        //Swift.print("\(self.dynamicType)" + ".onThumbUp() ")
        if(leftMouseDraggedEventListener != nil){NSEvent.removeMonitor(leftMouseDraggedEventListener!)}/*we remove a global mouse move event listener*/
    }
    func onMouseMove(event:NSEvent)-> NSEvent?{
        progress = Utils.progress(event.localPos(self).y, thumbHeight/2, height, thumbHeight)
        thumb!.y = Utils.thumbPosition(progress, height, thumbHeight)
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    /**
     * Handles actions and drawing states for the down event.
     */
    override func mouseDown(_ event:MouseEvent) {/*onSkinDown*/
        //Swift.print("\(self.dynamicType)" + ".mouseDown() ")
        progress = Utils.progress(event.event!.localPos(self).y, thumbHeight/2, height, thumbHeight)
        thumb!.y = Utils.thumbPosition(progress, height, thumbHeight)
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))/*sends the event*/
        leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching:[.leftMouseDragged], handler:onMouseMove )//we add a global mouse move event listener
        //super.mouseDown(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    override func mouseUp(_ event:MouseEvent) {
        if(leftMouseDraggedEventListener != nil){NSEvent.removeMonitor(leftMouseDraggedEventListener!)}//we remove a global mouse move event listener
    }
    override func onEvent(_ event:Event) {
        //Swift.print("\(self.dynamicType)" + ".onEvent() event: " + "\(event)")
        if(event.origin === thumb && event.type == ButtonEvent.down){onThumbDown()}//if thumbButton is down call onThumbDown
        else if(event.origin === thumb && event.type == ButtonEvent.up){onThumbUp()}//if thumbButton is down call onThumbUp
        //super.onEvent(event)/*forward events, or stop the bubbeling of events by commenting this line out*/
    }
    /**
     * PARAM: progress (0-1)
     */
    func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
        self.progress = Swift.max(0,Swift.min(1,progress))/*if the progress is more than 0 and less than 1 use progress, else use 0 if progress is less than 0 and 1 if its more than 1*/
        thumb!.y = Utils.thumbPosition(self.progress, height, thumbHeight)
        thumb?.applyOvershot(progress)/*<--we use the unclipped scalar value*/
    }
    /**
     * Sets the thumbs height and repositions the thumb accordingly
     */
    func setThumbHeightValue(_ thumbHeight:CGFloat) {/*Can't be named setThumbHeight because of objc*/
        self.thumbHeight = thumbHeight
        thumb!.setSize(thumb!.getWidth(), thumbHeight)
        thumb!.y = Utils.thumbPosition(progress, height, thumbHeight)
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width,height)
        thumb!.setSize(thumb!.width, height)
        thumb!.y = Utils.thumbPosition(progress, height, thumbHeight)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*required by all NSView subclasses*/
}
private class Utils{
    /**
     * Returns the x position of a nodes PARAM progress
     */
    class func thumbPosition(_ progress:CGFloat, _ height:CGFloat, _ thumbHeight:CGFloat)->CGFloat {
        let minThumbPos:CGFloat = height - thumbHeight/*Minimum thumb position*/
        return progress * minThumbPos
    }
    /**
     * Returns the progress derived from a node
     * RETURN: a number between 0 and 1
     */
    class func progress(_ mouseY:CGFloat,_ tempNodeMouseY:CGFloat,_ height:CGFloat,_ thumbHeight:CGFloat)->CGFloat {
        if(thumbHeight == height) {return 0}/*if the thumbHeight is the same as the height of the slider then return 0*/
        let progress:CGFloat = (mouseY-tempNodeMouseY) / (height-thumbHeight)
        return max(0,min(progress,1))/*Ensures that progress is between 0 and 1 and if its beyond 0 or 1 then it is 0 or 1*/
    }
}

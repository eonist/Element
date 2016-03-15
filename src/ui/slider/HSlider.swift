import Cocoa
/**
 * HSlider is a simple horizontal slider
 * @Note the reason we have two sliders instead of 1 is because otherwise the math and variable naming scheme becomes too complex (same goes for the idea of extending a Slider class)
 * // :TODO: consider having thumbWidth and thumbHeight, its just easier to understand
 */
class HSlider :Element{
    var progress:CGFloat
    var thumbWidth:CGFloat
    var thumb:Thumb?
    var tempThumbMouseX:CGFloat = 0/*This value holds the onDown position when you click the thumb*/
    var globalMouseMovedHandeler:AnyObject?//rename to leftMouseDraggedEventListener or draggedEventListner
    init(width:CGFloat, _ height:CGFloat, _ thumbWidth:CGFloat, progress:CGFloat = 0, parent:IElement? = nil, id:String? = nil, classId:String? = nil) {
        self.progress = progress
        self.thumbWidth = thumbWidth.isNaN ? height:thumbWidth
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        //skin.mouseEnabled = skin.buttonMode = false;
        thumb = addSubView(Thumb(width, thumbWidth,self))
        //setProgress(progress);
    }
    func onThumbDown(){
        //Swift.print("\(self.dynamicType)"+".onThumbDown() ")
        tempThumbMouseX = thumb!.localPos().x
        Swift.print("tempThumbMouseX: " + "\(tempThumbMouseX)")
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onThumbMove )//we add a global mouse move event listener
    }
    func onThumbMove(event:NSEvent)-> NSEvent?{
        //Swift.print("\(self.dynamicType)"+".onThumbMove() " + "localPos: " + "\(event.localPos(self))")
        //progress = Utils.progress(event.localPos(self).x, tempThumbMouseX, frame.width, thumbWidth)
        //thumb!.frame.y = Utils.thumbPosition(progress, frame.height, thumbHeight)
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    func onThumbUp(){
        Swift.print("\(self.dynamicType)" + ".onThumbUp() ")
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    func onMouseMove(event:NSEvent)-> NSEvent?{
        //progress = Utils.progress(event.localPos(self).x, thumbWidth/2, width, thumbWidth);
        //thumb!.frame.x = Utils.thumbPosition(progress, width, thumbWidth);
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    override func mouseUp(event: MouseEvent) {
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    override func onEvent(event: Event) {
        //Swift.print("\(self.dynamicType)" + ".onEvent() event: " + "\(event)")
        if(event.origin === thumb && event.type == ButtonEvent.down){onThumbDown()}//if thumbButton is down call onThumbDown
        else if(event.origin === thumb && event.type == ButtonEvent.up){onThumbUp()}//if thumbButton is down call onThumbUp
        //super.onEvent(event)/*forward events, or stop the bubbeling of events by commenting this line out*/
    }
    /**
     * @param progress (0-1)
     */
    func setProgressValue(progress:CGFloat){/*Can't be named setProgress because of objc*/
        self.progress = Swift.max(0,Swift.min(1,progress))/*if the progress is more than 0 and less than 1 use progress, else use 0 if progress is less than 0 and 1 if its more than 1*/
        //thumb!.frame.x = Utils.thumbPosition(self.progress, frame.width, thumbWidth)
        thumb?.applyOvershot(progress)/*<--we use the unclipped scalar value*/
    }
    /**
     * Sets the thumbs height and repositions the thumb accordingly
     */
    func setThumbWidthValue(thumbHeight:CGFloat) {/*Can't be named setThumbHeight because of objc*/
        self.thumbWidth = thumbHeight
        thumb!.setSize(thumbWidth, thumb!.getHeight())
        thumb!.frame.x = Utils.thumbPosition(progress, frame.width, thumbWidth)
    }
    override func setSize(width:CGFloat, _ height:CGFloat) {
        super.setSize(width,height);
        thumb!.setSize(thumb!.width, height);
        thumb!.frame.x = Utils.thumbPosition(progress, width, thumbWidth);
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
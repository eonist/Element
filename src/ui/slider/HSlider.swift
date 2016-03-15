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
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
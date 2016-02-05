import Cocoa
/**
 * VSlider is a simple vertical slider
 * @Note the reasan we have two sliders instead of 1 is because otherwise the math and variable naming scheme becomes too complex (same goes for the idea of extending a Slider class)
 * // :TODO: consider having thumbWidth and thumbHeight, its just easier to understand
 * // :TODO: rename thumbHeight to thumbWidth or?
 */
class VSlider :InteractiveView2{
    var thumb:Thumb?
    var globalMouseMovedHandeler:AnyObject?//rename to leftMouseDraggedEventListener or draggedEventListner
    var progress:CGFloat
    var tempThumbMouseY:CGFloat = 0
    var thumbHeight:CGFloat
    init(_ width: CGFloat, _ height: CGFloat,_ thumbHeight:CGFloat = CGFloat.NaN, _ progress:CGFloat = 0){
        self.progress = progress
        self.thumbHeight = thumbHeight.isNaN ? width:thumbHeight// :TODO: explain in a comment what this does
        super.init(frame: NSRect(0,0,width,height))
        createContent()
    }
    func createContent(){
        Swift.print("\(self.dynamicType)" + "createContent: ")
        let skin = SkinC(frame:NSRect(0,0,frame.width,frame.height))
        addSubview(skin)
        thumb = Thumb(40,40)
        addSubview(thumb!)
    }
    func onThumbDown(){
        Swift.print("onThumbDown")
        tempThumbMouseY = thumb!.localPos().y
        Swift.print("tempThumbMouseY: " + "\(tempThumbMouseY)")
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onThumbMove )
    }
    func onThumbMove(event:NSEvent)-> NSEvent?{
        Swift.print("onThumbMove " + "localPos: " + "\(event.localPos(self))")
        progress = Utils.progress(event.localPos(self).y, tempThumbMouseY, frame.height, thumbHeight);
        thumb!.frame.y = Utils.thumbPosition(progress, frame.height, thumbHeight);
        //post SliderEvent(SliderEvent.change,progress)
        return event
    }
    func onThumbUp(){
        Swift.print("onThumbUp")
        NSEvent.removeMonitor(globalMouseMovedHandeler!)
    }
    override func onEvent(event: Event) {
        if(event.origin === thumb && event.type == ButtonEvent.down){onThumbDown()}
        else if(event.origin === thumb && event.type == ButtonEvent.up){onThumbUp()}
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     * Returns the x position of a nodes @param progress
     */
    class func thumbPosition(progress:CGFloat, _ height:CGFloat, _ thumbHeight:CGFloat)->CGFloat {
        let minThumbPos:CGFloat = height - thumbHeight;/*Minimum thumb position*/
        return progress * minThumbPos
    }
    /**
     * Returns the progress derived from a node
     * @return a number between 0 and 1
     */
    class func progress(mouseY:CGFloat,_ tempNodeMouseY:CGFloat,_ height:CGFloat,_ thumbHeight:CGFloat)->CGFloat {
        if(thumbHeight == height) {return 0}/*if the thumbHeight is the same as the height of the slider then return 0*/
        let progress:CGFloat = (mouseY-tempNodeMouseY) / (height-thumbHeight)
        return max(0,min(progress,1))/*Ensures that progress is between 0 and 1 and if its beyond 0 or 1 then it is 0 or 1*/
    }
}
class Thumb:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        createContent()
    }
    func createContent(){
        //Swift.print("create content")
        let skin = SkinD(frame:NSRect(0,0,frame.width,frame.height))
        addSubview(skin)
    }
    override func mouseOver(event:MouseEvent) {
        Swift.print("\(self.dynamicType)" + " mouseOver() ")
        super.mouseOver(event)
    }
    override func mouseOut(event:MouseEvent) {
        Swift.print("\(self.dynamicType)" + " mouseOut() ")
        super.mouseOut(event)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//continue here:

//implement button2 with just mouseDown that sends ButtonEvent.down
//implement onEvent in interactiview2
//add type? to Event
//listen for origin === thumb && event.type == ButtonEvent.down in slider
//try iconbar

class Button2:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        //createContent()
    }
    override func mouseDown(event: MouseEvent) {
        super.onEvent(ButtonEvent(ButtonEvent.down,self))
    }
    override func mouseUp(event: MouseEvent) {
        super.onEvent(ButtonEvent(ButtonEvent.up,self))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
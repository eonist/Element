import Cocoa
@testable import Utils

class SwitchSlider:Element {
    var progress:CGFloat
    var leftMouseDraggedEventListener:Any?
    init(_ width:CGFloat, _ height:CGFloat, _ progress:CGFloat = 0, _ parent:IElement? = nil, _ id:String? = nil, _ classId:String? = nil) {
        self.progress = progress
        super.init(width,height,parent,id)
    }
    func onMouseMove(event:NSEvent)-> NSEvent?{
        progress = HSliderUtils.progress(event.localPos(self).x, 0/*thumbWidth/2*/, width, /*thumbWidth*/ 0)
        Swift.print("SwitchSlider.onMouseMove progress: " + "\(progress)")
        
        if(progress == 1 && !isChecked){
            setChecked(true)
            disableMouseUp = true
        }else if(progress == 0 && isChecked){
            setChecked(false)
            disableMouseUp = true
        }
        
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    /**
     * Handles actions and drawing states for the down event
     */
    override func mouseDown(_ event:MouseEvent) {
        Swift.print("SwitchSlider.mouseDown")
        progress = HSliderUtils.progress(event.event!.localPos(self).x, /*thumbWidth/2*/0, width, /*thumbWidth*/0)
        leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching:[.leftMouseDragged], handler:onMouseMove )//we add a global mouse move event listener
        //super.mouseDown(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    override func mouseUp(_ event:MouseEvent) {
        if(leftMouseDraggedEventListener != nil){NSEvent.removeMonitor(leftMouseDraggedEventListener!);leftMouseDraggedEventListener = nil}//we remove a global mouse move event listener
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

import Cocoa
/**
 * NOTE: the titleView has a working model for centering things in css
 */
class TitleView:CustomView{
    var textArea:TextArea?
    var leftMouseDraggedEventListener:AnyObject?
    var mouseDownPos:CGPoint?/*Store the mouseDown offset, when moving the window*/
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    override func createTitleBar() {
        super.createTitleBar()
        textArea = addSubView(TextArea(NaN,24,"Title goes here",self,"winTitle"))
        textArea!.text?.isInteractive = false/*Disable interactivity on the text*/
    }
    override func mouseDown(event: MouseEvent) {
        //Swift.print("TitleView.mouseDown event.immediate: \(event.immediate)" + " event.origin: \(event.origin)")
        if(event.immediate === textArea){
            mouseDownPos = self.winMousePos
            if(leftMouseDraggedEventListener == nil) {leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:self.onMove ) }//we add a global mouse move event listener
            else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
        }
    }
    override func mouseUp(event: MouseEvent) {
        //Swift.print("mouseUp")
        if(leftMouseDraggedEventListener != nil){
            NSEvent.removeMonitor(leftMouseDraggedEventListener!)
            leftMouseDraggedEventListener = nil//<--this part may not be needed , seems to be needed
        }
    }
    func onMove(event:NSEvent) -> NSEvent? {
        //Swift.print("PageController.onMove()")
        let winPos:CGPoint = self.window!.unFlipScreenPosition(self.window!.flippedScreenPosition - mouseDownPos!)
        WinModifier.position(self.window!, winPos)
        return event
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
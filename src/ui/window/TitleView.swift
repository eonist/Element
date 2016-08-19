import Cocoa
/**
 * NOTE: the titleView has a working model for centering things in css
 */
class TitleView:CustomView{
    var textArea:TextArea?
    var leftMouseDraggedEventListener:AnyObject?
    var mouseDownPos:CGPoint?/*store the mouseDown offset, when moving the window*/
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        var css:String = ""
        css += "TextArea#winTitle{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "width:100%;"
        css +=     "offset:75px,0px;"
        css +=     "fill-alpha:1;"
        css +=     "fill:yellow;"
        css +=     "line-alpha:0;"
        css +=     "line-thickness:0px;"
        css +=     "background:true;"
        css += "}"
        css += "TextArea#winTitle Text{"
        css +=     "width:100%;"
        css +=     "height:16px;"
        css +=     "offset:-75px,0px;"//<- set the width of the text to 100% and the offset to -the width of the titlebarIconContainer
        css +=     "scrollable:false;"
        css +=     "multiline:false;"
        css +=     "wordWrap:true;"
        css +=     "align:center;"
        css +=     "margin-top:0px;"
        css +=     "margin-left:4px;"
        css +=     "font:Helvetica Neue Medium;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css +=     "selectable:false;"
        css += "}"
        StyleManager.addStyle(css)
        
        super.resolveSkin()
        
        textArea = addSubView(TextArea(NaN,24,"Title goes here",self,"winTitle"))
        textArea!.text?.isInteractive = false
    }
    override func mouseDown(event: MouseEvent) {
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
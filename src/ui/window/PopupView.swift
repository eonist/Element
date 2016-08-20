import Cocoa

/**
 * NOTE: the difference between local and global monitors is that local takes care of events that happen inside an app window, and the global handle events that also is detected outside an app window.
 */
class PopupView:WindowView{
    var leftMouseDownEventListener:AnyObject?
    override func resolveSkin() {
        Swift.print("PopupView.resolveSkin")
        StyleManager.addStyle("Window#special{fill:green;}")
        super.resolveSkin()
        if(leftMouseDownEventListener == nil) {leftMouseDownEventListener = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDownMask], handler:self.onMouseDown ) }//we add a global mouse move event listener
        else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
    }
    
    func onMouseDown(event:NSEvent) -> NSEvent? {
        Swift.print("PopupView.onMouseDown()")
        super.onEvent(Event(Event.update,self))
        if(leftMouseDownEventListener != nil){
            NSEvent.removeMonitor(leftMouseDownEventListener!)
            leftMouseDownEventListener = nil
        }
        //TODO: set the event to it self again here
        self.window!.close()
        return event
    }
}

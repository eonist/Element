import Cocoa
@testable import Utils
/**
 * NOTE: the difference between local and global monitors is that local takes care of events that happen inside an app window, and the global handle events that also is detected outside an app window.
 * TODO: add support for NSNotification: windowDidResignKey -> close the popup window when this event happens
 */
class PopupView:WindowView{
    var leftMouseDownEventListener:Any?
    override func resolveSkin() {
        Swift.print("PopupView.resolveSkin")
        StyleManager.addStyle("Window#special{fill:green;}")
        super.resolveSkin()
        if(leftMouseDownEventListener == nil) {leftMouseDownEventListener = NSEvent.addLocalMonitorForEvents(matching:[.leftMouseDragged], handler:self.onMouseDown ) }//we add a global mouse move event listener
        else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
    }
    func onMouseDown(event:NSEvent) -> NSEvent? {
        Swift.print("PopupView.onMouseDown()")
        Swift.print("self.localPos: " + "\(self.localPos())")
        if(!CGRect(CGPoint(),frame.size).contains(self.localPos())){/*click outside window, but must hit another app window*/
            super.onEvent(Event(Event.update,self))/*notifies the initiator of the PopupWin that it will close*/
            if(leftMouseDownEventListener != nil){
                NSEvent.removeMonitor(leftMouseDownEventListener!)
                leftMouseDownEventListener = nil
            }
            //TODO: Set the event to it self again here
            self.window!.close()
        }
        return event
    }
}
/*

Implement this if you want the popupwin to be closed if the app looses focus:

- (void)setupWindowForEvents{
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResignKey:) name:NSWindowDidResignMainNotification object:self];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResignKey:) name:NSWindowDidResignKeyNotification object:self];
}

-(void)windowDidResignKey:(NSNotification *)note {
NSLog(@"notification");
[self close];
}

*/

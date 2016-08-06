import Cocoa
/**
 * 
 */
class Window:NSWindow, NSApplicationDelegate, NSWindowDelegate/*,IElement*/ {
    var view:NSView?
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    /**
     * NOTE: remember to not set the width or height for the window in the css if you want the resizing working
     * NOTE: self.opaque = false/*use this value in conjunction with a transperant color and you can make the window transperant*/
     * TODO: impliment the max and min sizes into the constructor arguments
     */
    required init(_ width:CGFloat = 600,_ height:CGFloat = 400/*, _ x:CGFloat = 0 , _ y:CGFloat = 0*/){/*required prefix in the init is so that instances can be created via factory design patterns*/
        let styleMask:Int = NSBorderlessWindowMask|NSResizableWindowMask/*represents the window attributes*/
        let rect:NSRect = NSMakeRect(00, 00, width, height)
        
        //COntinue here: use x and y and explaine why in a param note. Also use the Align method to get the point you need to position the window on creation! nice!
        
        super.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.Buffered, `defer`: false)//NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
        self.backgroundColor = NSColor.clearColor()/*Sets the window background color*/
        self.makeKeyAndOrderFront(self)/*THis moves the window to front and makes it key, should also be settable from within the win itself, test this*/
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        //self.movableByWindowBackground = true/*This enables you do drag the window around via the background*/
        //self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.movableByWindowBackground = false/*This enables you do drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        resolveSkin()
    }
    func windowDidResize(notification: NSNotification) {
        Swift.print("Window.windowDidResize")
    }
    /**
     * We use the resolveSkin method since this is the common way to implement functionality in this framework
     */
    func resolveSkin(){
        self.contentView = WindowView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    /**
     * I think this serves as a block for closing, i.e: prompt the user to save etc
     */
    func windowShouldClose(sender: AnyObject) -> Bool {
        Swift.print("windowShouldClose")
        return true
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
import Cocoa
@testable import Utils

class Window:NSWindow, NSApplicationDelegate, NSWindowDelegate/*,IElement*/ {
    lazy var view:NSView = {WindowView(self.frame.width,self.frame.height)}()/*Sets the mainview of the window*/
    override var canBecomeMain:Bool{return true}
    override var canBecomeKey:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    /**
     * NOTE: Remember to not set the width or height for the window in the css if you want the resizing working
     * NOTE: self.opaque = false/*use this value in conjunction with a transperant color and you can make the window transperant*/
     * NOTE: self.acceptsMouseMovedEvents = true/*<--new, could enable you to use the overide mouseMoved*/
     * TODO: Implement the max and min sizes into the constructor arguments
     * TODO: Implement x and y for the win on init (This is tricky to get right, carefull)
     */
    required init(_ width:CGFloat = 600,_ height:CGFloat = 400){/*required prefix in the init is so that instances can be created via factory design patterns*/
        let styleMask:NSWindowStyleMask = [.borderless, .resizable/*,.titled*/]/*represents the window attributes*/
        let rect:NSRect = NSMakeRect(0, 0, width, height)
        super.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.buffered, defer: false)
        self.backgroundColor = .white/*Sets the window background color*/
        //self.isOpaque = false
        self.makeKeyAndOrderFront(self)/*This moves the window to front and makes it key, should also be settable from within the win itself, test this*/
        self.hasShadow = false/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        //
        
        /*self.titlebarAppearsTransparent  =   true
         self.titleVisibility             =   .visible
         self.showsToolbarButton          =   false
         self.standardWindowButton(NSWindowButton.fullScreenButton)?.isHidden   =   true
         self.standardWindowButton(NSWindowButton.miniaturizeButton)?.isHidden  =   true
         self.standardWindowButton(NSWindowButton.closeButton)?.isHidden        =   true
         self.standardWindowButton(NSWindowButton.zoomButton)?.isHidden         =   true*/
        //self.tit
        
        //self.center()/*centers the window, this can also be done via WinModifier.align right after the init, carefull with self.center() as it overrides other alignment methods*/
        self.isReleasedWhenClosed = false/*<--This makes it possible to close and open the same window programtically, true for panels, false for unique docwin etc*/
        self.isMovableByWindowBackground = false/*This enables you do drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        //resolveSkin()
        self.contentView                 =   view1
        view1.wantsLayer                =   true
        //view1.layer!.cornerRadius       =   10
        view1.layer!.backgroundColor    =   NSColor.white.cgColor
       
        view1.layer?.masksToBounds    = false
        view1.layer?.shadowColor      = NSColor.red.cgColor;
        view1.layer?.shadowOpacity    = 1;
        view1.layer?.shadowOffset     = CGSize(10, -3);
        view1.layer?.shadowRadius     = 15.0;
        view1.layer?.shouldRasterize  = true;
        //self.invalidateShadow()
    }
    let view1   =   NSView()

    /**
     * Override this to add custom window resize code
     */
    func windowDidResize(_ notification: Notification) {
        //Swift.print("Window.windowDidResize")
        //(self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
    /**
     * We use the resolveSkin method since this is the common way to implement functionality in this framework
     */
    func resolveSkin(){
        _ = contentView
    }
    /**
     * I think this serves as a block for closing, i.e: prompt the user to save etc
     */
    func windowShouldClose(sender:AnyObject) -> Bool {
        //Swift.print("windowShouldClose")
        return true
    }
}

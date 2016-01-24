import Cocoa
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
    init(_ width:CGFloat = 600,_ height:CGFloat = 400){
        let styleMask:Int = NSResizableWindowMask|NSFullSizeContentViewWindowMask
        let rect:NSRect = NSMakeRect(0, 0, width, height)
        super.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.Buffered, `defer`: false)//NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
        //super.init(contentRect: Win.sizeRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask|NSFullSizeContentViewWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.contentView!.wantsLayer = true;/*this can and is set in the view*/
        self.backgroundColor = NSColor.greenColor().alpha(0.2)
        self.opaque = false
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        //self.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.titlebarAppearsTransparent = true
        self.center()
        
        //self.contentView = view
        //self.title = ""/*Sets the title of the window*/
        self.title = ""//GitSync
        
        self.delegate = self
        
        let visualEffectView = NSVisualEffectView(frame: NSMakeRect(0, 0, Win.sizeRect.width, Win.sizeRect.height))
        visualEffectView.material = NSVisualEffectMaterial.AppearanceBased//Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        visualEffectView.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        visualEffectView.state = NSVisualEffectState.Active
        
        self.contentView?.addSubview(visualEffectView)
    }
    /**
     * We use the resolveSkin method since this is the common way to implement functionality in this framework
     */
    func resolveSkin(){
       
        //self.contentView = WindowView(frame.width,frame.height)/*Sets the mainview of the window*/
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



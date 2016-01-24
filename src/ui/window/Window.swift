import Cocoa
class Window:NSWindow, NSApplicationDelegate, NSWindowDelegate/*,IElement*/ {
    
    var view:NSView?
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    let tempView:NSVisualEffectView?
    /**
     * NOTE: remember to not set the width or height for the window in the css if you want the resizing working
     * NOTE: self.opaque = false/*use this value in conjunction with a transperant color and you can make the window transperant*/
     * TODO: impliment the max and min sizes into the constructor arguments
     */
    init(_ width:CGFloat = 600,_ height:CGFloat = 400){
        let styleMask:Int = NSBorderlessWindowMask|NSResizableWindowMask
        let rect:NSRect = NSMakeRect(0, 0, width, height)
        
        let visualEffectView = NSVisualEffectView(frame: NSMakeRect(0, 0, Win.sizeRect.width, Win.sizeRect.height))
        visualEffectView.material = NSVisualEffectMaterial.AppearanceBased//Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        visualEffectView.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        visualEffectView.state = NSVisualEffectState.Active
        visualEffectView.maskImage = self._maskImage(cornerRadius: 20.0)
        tempView = visualEffectView
        
        super.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.Buffered, `defer`: false)//NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
        self.backgroundColor = NSColor.clearColor()/*Sets the window background color*/
        self.makeKeyAndOrderFront(self)/*THis moves the window to front and makes it key, should also be settable from within the win itself, test this*/
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        self.movableByWindowBackground = true/*This enables you do drag the window around via the background*/
        self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        //resolveSkin()
        
        
        self.contentView?.addSubview(visualEffectView)
        
        
        resolveSkin()
    }
    func _maskImage(cornerRadius cornerRadius: CGFloat) -> NSImage {
        let edgeLength = 2.0 * cornerRadius + 1.0
        let maskImage = NSImage(size: NSSize(width: edgeLength, height: edgeLength), flipped: false) { rect in
            let bezierPath = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
            NSColor.blackColor().set()
            bezierPath.fill()
            return true
        }
        maskImage.capInsets = NSEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius)
        maskImage.resizingMode = .Stretch
        return maskImage
    }
    /**
     * We use the resolveSkin method since this is the common way to implement functionality in this framework
     */
    func resolveSkin(){
        self.tempView!.addSubview(WindowView(frame.width,frame.height))/*Sets the mainview of the window*/
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



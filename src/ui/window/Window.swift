import Cocoa
/**
 * NOTE: remember to not set the width or height for the window in the css if you want the resizing working
 * NOTE: self.opaque = false/*use this value in conjunction with a transperant color and you can make the window transperant*/
 * // :TODO: impliment the max and min sizes into the constructor arguments
 * NOTE: /*NSBorderlessWindowMask*///NSTitledWindowMask/*A title bar*/|NSResizableWindowMask/*A resize bar, border, or box*/|NSMiniaturizableWindowMask/*A miniaturize button*/|NSClosableWindowMask/*A close button*/
 */
class Window:NSWindow, NSApplicationDelegate, NSWindowDelegate/*,IElement*/ {
    
    var id : String?/*css selector id*/
    var view:NSView?
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    
    /**
     *
     */
    init(_ width:CGFloat = 600,_ height:CGFloat = 400,_ id:String? = nil){
        
        let styleMask:Int = NSBorderlessWindowMask
        let rect:NSRect = NSMakeRect(0, 0, width, height)
        //self.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.Buffered, `defer`: false)
        self.id = id
        super.init(contentRect: rect, styleMask:styleMask , backing: NSBackingStoreType.Buffered, `defer`: false)//NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
        self.contentView!.wantsLayer = true;
        self.backgroundColor = NSColor.orangeColor()/*Sets the window background color*/
        self.makeKeyAndOrderFront(self)/*THis moves the window to front and makes it key, should also be settable from within the win itself, test this*/
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        self.movableByWindowBackground = true/*This enables you do drag the window around via the background*/
        self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        //view.wantsLayer = true;
        //self.contentView = Element(frame.width,frame.height,self)
        
        //self.title = ""
        createContent()
        self.delegate = self
    }
    /*override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
    
    }*/
    /**
     *
     */
    func createContent(){
        
    }
        
    
    /*
    * I think this serves as a block for closing, i. promt the user to save etc
    */
    func windowShouldClose(sender: AnyObject) -> Bool {
        Swift.print("windowShouldClose")
        return true
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
/**
 * NOTE: we dont extend Element or InteractiveView here because this view does not need the features that InteractiveView brings
 */
class WindowView:FlippedView,IElement{
    var id : String?/*css selector id*/
    var parent:IElement?
    var state:String = SkinStates.none
    var skin:ISkin?
    var style:IStyle = Style.clear
    init(_ width: CGFloat, _ height: CGFloat, _ id:String) {
        self.id = id;
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


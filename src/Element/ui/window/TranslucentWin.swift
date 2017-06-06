import Cocoa
@testable import Utils
/**
 * Used for Translucent look
 */
class TranslucentWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    override var canBecomeMain:Bool{return true}
    override var canBecomeKey:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    var visualEffectView:TranslucentView?/*We set the to the background*/
    
    override init(contentRect:NSRect, styleMask style:NSWindowStyleMask, backing bufferingType:NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect:contentRect, styleMask: [.titled, .resizable,.fullSizeContentView], backing:NSBackingStoreType.buffered, defer: false)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
        Swift.print("frame.origin: " + "\(frame.origin)")
        self.contentView!.wantsLayer = true/*this can and is set in the view*/
        self.backgroundColor = NSColor.clear/*Sets the window background color*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMain()//makes it the apps main menu?
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        //self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.isMovableByWindowBackground = false/*This enables you to drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        self.isMovable = false
        
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        self.standardWindowButton(.closeButton)?.isHidden = true
        
        self.contentView = InteractiveView2(frame:contentRect) //FlippedView(frame:contentRect)
        visualEffectView = TranslucentView(frame:contentRect)
        self.contentView?.addSubview(visualEffectView!)
        //override and add view to contentview. 
    }
    func windowDidResize(_ notification: Notification) {
        Swift.print("CustomWin.windowDidResize " + "\(self.frame.size)")
        visualEffectView!.setFrameSize(self.frame.size)
    }
}

class TranslucentView:NSVisualEffectView{
    let cornerRadius:CGFloat = 8
    override var isFlipped:Bool {return true}/*Organizes your view from top to bottom*/
    override init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        if #available(OSX 10.11, *) {
            self.material = NSVisualEffectMaterial.ultraDark
        } else {
            // Fallback on earlier versions
        }/*AppearanceBased,Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu*/
        self.blendingMode = .behindWindow
        self.state = .active
        self.maskImage = maskImage(cornerRadius: cornerRadius)/*this line applies the mask to the view*/
    }
    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        self.maskImage = maskImage(cornerRadius: cornerRadius)/*<--we recreate and add the imageMask when the view resizes*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension TranslucentView{
    func maskImage(cornerRadius: CGFloat) -> NSImage {
        let edgeLength = 2.0 * cornerRadius + 1.0
        //Swift.print("edgeLength: " + "\(edgeLength)")
        let maskImage = NSImage(size: NSSize(width: edgeLength, height: edgeLength), flipped: false) { rect in
            let bezierPath = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
            NSColor.black.set()
            bezierPath.fill()
            return true
        }
        maskImage.capInsets = EdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius)
        maskImage.resizingMode = .stretch
        return maskImage
    }
}
/*
 //just createa custom win and add content bellow super.init ✨
 //override and add view to contentview.
 
convenience init(_ w:CGFloat,_ h:CGFloat){
    self.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
}
 
*/

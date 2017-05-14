import Cocoa
@testable import Element
@testable import Utils
/**
 * Used for Translucent look
 */
class TranslucencyWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    let w:CGFloat = 1000//500//350//
    let h:CGFloat = 800//400//300//
    override var canBecomeMain:Bool{return true}
    override var canBecomeKey:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    var visualEffectView:TranslucencyView?/*We set the to the background*/
    override init(contentRect:NSRect, styleMask style:NSWindowStyleMask, backing bufferingType:NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
        Swift.print("frame.origin: " + "\(frame.origin)")
        self.contentView!.wantsLayer = true/*this can and is set in the view*/
        self.backgroundColor = NSColor.clear/*Sets the window background color*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMain()//makes it the apps main menu?
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        //self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.isMovableByWindowBackground = false/*This enables you to drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        self.contentView = FlippedView(frame:NSRect(0,0,w,h))
        visualEffectView = TranslucencyView(frame:NSRect(0,0,w,h))
        self.contentView?.addSubview(visualEffectView!)
        let view = ViewType.view(.basic,CGSize(w,h))/*Sets the mainview of the window*/
        self.contentView?.addSubview(view)
    }
    func windowDidResize(_ notification: Notification) {
        //Swift.print("CustomWin.windowDidResize " + "\(self.frame.size)")
        visualEffectView!.setFrameSize(self.frame.size)
    }
}

class TranslucencyView:NSVisualEffectView{
    let cornerRadius:CGFloat = 8
    override var isFlipped:Bool {return true}/*Organizes your view from top to bottom*/
    override init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        self.material = .light/*AppearanceBased,Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu*/
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

extension TranslucencyView{
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

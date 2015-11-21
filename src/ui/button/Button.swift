import Cocoa

class Button:Element {
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Button.init()")
        super.init(width, height, parent, id)
        //acceptsTouchEvents = false//only for swipes,pinch etc
        
        addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
        //
        
        
        //The problem is that you create the Items in superviews drawrect method. move the interface creation to didLoadWin or alike
        //remove swift prints in the current implementation
        
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func getClassType()->String{
        return String(Button)
    }
    override func mouseEntered( event: NSEvent){
        
        
        
            skinState = SkinStates.over
            Swift.print("mouseEntered: " + "\(super.skinState)")
            
            //super.mouseEntered(event)
            needsDisplay = true;
        
    }
    override func mouseExited(event: NSEvent){
        //isWithin = false
        Swift.print("mouseExited: " + "\(self.skinState)")
        //super.mouseExited(event)
        
        
    }
    override func mouseDown(theEvent: NSEvent) {
        skinState = SkinStates.down
        Swift.print("mouseDownEvent: " + "\(self.skinState)")
        //super.mouseDown(theEvent)
    }
    override func mouseUp(theEvent: NSEvent) {
        skinState = SkinStates.none
        Swift.print("mouseUpEvent: " + "\(self.skinState)")
        //super.mouseDown(theEvent)
        
    }
}

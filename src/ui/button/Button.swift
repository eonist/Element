import Cocoa

class Button:Element {
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Button.init()")
        super.init(width, height, parent, id)
        //acceptsTouchEvents = false//only for swipes,pinch etc
        
        addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
  
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
        skinState = SkinStates.none
        Swift.print("mouseExited: " + "\(self.skinState)")
        //super.mouseExited(event)
        
        
    }
    override func mouseDown(theEvent: NSEvent) {
        skinState = SkinStates.down+" "+SkinStates.over;
        Swift.print("mouseDownEvent: " + "\(self.skinState)")
        //super.mouseDown(theEvent)
    }
    override func mouseUp(theEvent: NSEvent) {
        
        let mousePos:NSPoint = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mousePos: " + String(mousePos))
        let hitTestPoint:Bool = NSPointInRect(mousePos, frame)
        Swift.print("hitTestPoint: " + String(hitTestPoint))
        //NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        
        //this.hitTestPoint(mouseEvent.stageX, mouseEvent.stageY) ? releaseInside():releaseOutside();
        
        skinState = SkinStates.none
        Swift.print("mouseUpEvent: " + "\(self.skinState)")
        
        //super.mouseDown(theEvent)
        
    }
    func mouseUpOutside(theEvent: NSEvent){
        
    }
}

import Cocoa

class Button:Element {
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Button.init()")
        super.init(width, height, parent, id)
        addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func getClassType()->String{
        return String(Button)
    }
    /**
     * Handles actions and drawing states for the mouseEntered event.
     */
    override func mouseEntered( event: NSEvent){
        
        skinState = SkinStates.over
        Swift.print("mouseEntered: " + "\(super.skinState)")
            
        //super.mouseEntered(event)
        //needsDisplay = true;
        
    }
    /**
     * Handles actions and drawing states for the mouseExited event.
     */
    override func mouseExited(event: NSEvent){
        //isWithin = false
        skinState = SkinStates.none
        Swift.print("mouseExited: " + "\(self.skinState)")
        //super.mouseExited(event)
        
        
    }
    /**
     * Handles actions and drawing states for the down event.
     */
    override func mouseDown(theEvent: NSEvent) {
        skinState = SkinStates.down+" "+SkinStates.over;
        Swift.print("mouseDownEvent: " + "\(self.skinState)")
        //super.mouseDown(theEvent)
    }
    /**
     * Handles actions and drawing states for the release event.
     * @Note: bubbling= true was added to make Stepper class dragable
     */
    func mouseUpInside(theEvent: NSEvent){
        skinState = SkinStates.over;// :TODO: why in two lines like this?
        Swift.print("mouseUpInside: " + "\(self.skinState)")
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event.
     * @Note: bubbling = true was added to make Stepper class dragable
     */
    func mouseUpOutside(theEvent: NSEvent){
        skinState = SkinStates.none
        Swift.print("mouseUpOutside: " + "\(self.skinState)")
    }
    override func mouseUp(theEvent: NSEvent) {
        
        let mousePos:NSPoint = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mousePos: " + String(mousePos))
        let hitTestPoint:Bool = NSPointInRect(mousePos, frame)
        Swift.print("hitTestPoint: " + String(hitTestPoint))
        //NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        
        self.hitTestPoint(theEvent.locationInWindow) ? mouseUpInside(theEvent) : mouseUpOutside(theEvent);/*if the event was on this button call triggerRelease, else triggerReleaseOutside*/
        
        skinState = SkinStates.none
        //Swift.print("mouseUpEvent: " + "\(self.skinState)")
        
        //super.mouseDown(theEvent)
        
        
        //continue here, implement states for the upInside and upOutside and continue with the stateMaschine
        
    }
    
}

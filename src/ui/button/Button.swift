import Cocoa
/*
 * // :TODO: it could be possible to merge the two skin lines in every event handler somehow
 * // :TODO: impliment IFocusable and IDisablble in this class, the argument that the button must be super simple doesnt hold, if you want a simpler button you can just make an alternate Button class
 */
class Button:Element {
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Button.init()")
        super.init(width, height, parent, id)
        addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * Handles actions and drawing states for the mouseEntered event.
     */
    override func mouseEntered( event: NSEvent){
        Swift.print("mouseEntered: ")
        state = SkinStates.over
        Swift.print("skinstate: " + getSkinState())
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.rollOver, object:self)
        super.mouseEntered(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Handles actions and drawing states for the mouseExited event.
     */
    override func mouseExited(event: NSEvent){
        Swift.print("mouseExited: ")
        state = SkinStates.none
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.rollOut, object:self)
        super.mouseExited(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Handles actions and drawing states for the down event.
     */
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("mouseDownEvent: ")
        state = SkinStates.down+" "+SkinStates.over;
        setSkinState(getSkinState());
        
        
        //continue here: add userInfo to the postNotificationName
        
        
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.down, object:self)
        super.mouseDown(theEvent)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Handles actions and drawing states for the release event.
     * @Note: bubbling= true was added to make Stepper class dragable
     */
    func mouseUpInside(theEvent: NSEvent){
        Swift.print("mouseUpInside: ")
        state = SkinStates.over;// :TODO: why in two lines like this?
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.releaseInside, object:self)
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event.
     * @Note: bubbling = true was added to make Stepper class dragable
     */
    func mouseUpOutside(theEvent: NSEvent){
        Swift.print("mouseUpOutside: ")
        state = SkinStates.none
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.releaseOutside, object:self)
    }
    override func mouseUp(theEvent: NSEvent) {
        //let mousePos:NSPoint = convertPoint(theEvent.locationInWindow, fromView: nil)
        //Swift.print("mousePos: " + String(mousePos))
        //let hitTestPoint:Bool = NSPointInRect(mousePos, frame)
        //Swift.print("hitTestPoint: " + String(hitTestPoint))
        //NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        self.hitTestPoint(theEvent.locationInWindow) ? mouseUpInside(theEvent) : mouseUpOutside(theEvent);/*if the event was on this button call triggerRelease, else triggerReleaseOutside*/
        //Swift.print("mouseUpEvent: " + "\(self.skinState)")
        super.mouseUp(theEvent)/*passes on the event to the nextResponder, NSView parents etc*/
    }
}

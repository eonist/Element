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
    override func mouseOver() {
        //Swift.print("Button.mouseOver() ")
        if(NSEvent.pressedMouseButtons() == 0){/*Dont call triggerRollOver if primary mouse button has been pressed, this is to avoid stuck buttons*/
            //state = SkinStates.over
            //Swift.print("skinstate: " + getSkinState())
            //setSkinState(getSkinState());
            NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.rollOver, object:self)
        }
    }
    /**
     * Handles actions and drawing states for the mouseOut action.
     */
    override func mouseOut() {
        //Swift.print("Button.mouseOut() ")
        //Swift.print("event.pressedMouseButtons(): " + String(NSEvent.pressedMouseButtons()))/*0 == no mouse button, 1 == left mouse button, 2 == right mouseButton*/
        if(NSEvent.pressedMouseButtons() == 0){/*This is to avoid stuck buttons*/
            state = SkinStates.none
            setSkinState(getSkinState());
            NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.rollOut, object:self)
        }
    }
    /**
     * Handles actions and drawing states for the down event.
     */
    override func mouseDown(theEvent: NSEvent) {
        //Swift.print("Button.mouseDown() ")
        state = SkinStates.down+" "+SkinStates.over;
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.down, object:self)
        super.mouseDown(theEvent)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Handles actions and drawing states for the release event.
     * @Note: bubbling= true was added to make Stepper class dragable
     */
    override func mouseUpInside(theEvent: NSEvent){
        //Swift.print("Button.mouseUpInside: ")
        state = SkinStates.over;// :TODO: why in two lines like this?
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.releaseInside, object:self)
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event.
     * @Note: bubbling = true was added to make Stepper class dragable
     */
    override func mouseUpOutside(theEvent: NSEvent){
        //Swift.print("Button.mouseUpOutside: ")
        state = SkinStates.none
        setSkinState(getSkinState());
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.releaseOutside, object:self)
    }
    
}

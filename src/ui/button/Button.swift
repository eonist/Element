import Cocoa
/*
 * // :TODO: it could be possible to merge the two skin lines in every event handler somehow
 * // :TODO: impliment IFocusable and IDisablble in this class, the argument that the button must be super simple doesnt hold, if you want a simpler button you can just make an alternate Button class
 * // :TODO: If the mouse gets stuck and wont fire the mouseUp after a mouseDown call, then the app should not fail when clicking down again somewhere else, this means we need to centralize the eventListner for mouseUp/mouseDown using global instead of locla could work
 */
class Button:Element {
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Button.init()")
        super.init(width, height, parent, id)
        //addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    /**
     * Handles actions and drawing states for the mouseEntered event.
     */
    override func mouseOver(event:MouseEvent) {
        //Swift.print("Button.mouseOver() ")
        if(NSEvent.pressedMouseButtons() == 0){/*Dont call triggerRollOver if primary mouse button has been pressed, this is to avoid stuck buttons*/
            state = SkinStates.over
            //Swift.print("skinstate: " + getSkinState())
            setSkinState(getSkinState())
            super.onEvent(ButtonEvent(ButtonEvent.over,self/*,self*/))
        }
    }
    /**
     * Handles actions and drawing states for the mouseOut action.
     */
    override func mouseOut(event:MouseEvent) {
        //Swift.print("Button.mouseOut() ")
        //Swift.print("event.pressedMouseButtons(): " + String(NSEvent.pressedMouseButtons()))/*0 == no mouse button, 1 == left mouse button, 2 == right mouseButton*/
        if(NSEvent.pressedMouseButtons() == 0){/*This is to avoid stuck buttons*/
            state = SkinStates.none
            setSkinState(getSkinState())
            super.onEvent(ButtonEvent(ButtonEvent.out,self/*,self*/))
        }
    }
    /**
     * Handles actions and drawing states for the down event.
     */
    override func mouseDown(event:MouseEvent) {
        //Swift.print("Button.mouseDown() ")
        state = SkinStates.down+" "+SkinStates.over
        setSkinState(getSkinState());
        //super.mouseDown(event)/*passes on the event to the nextResponder, NSView parents etc*/
        super.onEvent(ButtonEvent(ButtonEvent.down,self/*,self*/))
    }
    /**
     * Handles actions and drawing states for the release event.
     * @Note: bubbling= true was added to make Stepper class dragable
     */
    override func mouseUpInside(event:MouseEvent){
        //Swift.print("Button.mouseUpInside: ")
        state = SkinStates.over;// :TODO: why in two lines like this?
        setSkinState(getSkinState())
        super.onEvent(ButtonEvent(ButtonEvent.upInside,self/*,self*/))
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event.
     * @Note: bubbling = true was added to make Stepper class dragable
     */
    override func mouseUpOutside(event:MouseEvent){
        //Swift.print("Button.mouseUpOutside: ")
        state = SkinStates.none
        setSkinState(getSkinState())
        super.onEvent(ButtonEvent(ButtonEvent.upOutside,self/*,self*/))
    }
    /**
     * Convenince
     * NOTE: This method is important to the behaviour of the LeverStepper for instance
     * LEGACY NOTE: This method was turned off temporarily, because it could fire after, this could be resolved by moving the mouseUp call in INteractiveView2 to before the mouseUpInside and mouseUpOutside calls.
     */
    override func mouseUp(event: MouseEvent) {
        //Swift.print("Button.mouseUp: ")
        super.onEvent(ButtonEvent(ButtonEvent.up,self/*,self*/))
    }
    override func hitTest(aPoint: NSPoint) -> NSView? {//TODO: this method can be removed
        //Swift.print("\(self.dynamicType)"+".hitTest() aPoint: " + "\(aPoint)")
        return super.hitTest(aPoint)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

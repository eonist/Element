import Cocoa
@testable import Utils
/**
 * TODO: It could be possible to merge the two skin lines in every event handler somehow
 * TODO: Impliment IFocusable and IDisablble in this class, the argument that the button must be super simple doesnt hold, if you want a simpler button you can just make an alternate Button class
 * TODO: If the mouse gets stuck and wont fire the mouseUp after a mouseDown call, then the app should not fail when clicking down again somewhere else, this means we need to centralize the eventListner for mouseUp/mouseDown using global instead of locla could work
 */
class Button:Element {
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        self.init(width, height, parent, id)
        //addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    /**
     * Handles actions and drawing states for the mouseEntered event
     */
    override func mouseOver(_ event:MouseEvent) {
        if(NSEvent.pressedMouseButtons() == 0){/*Dont call triggerRollOver if primary mouse button has been pressed, this is to avoid stuck buttons*/
            state = SkinStates.over
            setSkinState(getSkinState())
            super.onEvent(ButtonEvent(ButtonEvent.over,self))
        }
    }
    /**
     * Handles actions and drawing states for the mouseOut action
     */
    override func mouseOut(_ event:MouseEvent) {
        if(NSEvent.pressedMouseButtons() == 0){/*This is to avoid stuck buttons, 0 == no mouse button, 1 == left mouse button, 2 == right mouseButton*/
            state = SkinStates.none
            setSkinState(getSkinState())
            super.onEvent(ButtonEvent(ButtonEvent.out,self))
        }
    }
    /**
     * Handles actions and drawing states for the down event
     */
    override func mouseDown(_ event:MouseEvent) {
        state = SkinStates.down+" "+SkinStates.over
        setSkinState(getSkinState())
        //super.mouseDown(event)/*passes on the event to the nextResponder, NSView parents etc*/
        super.onEvent(ButtonEvent(ButtonEvent.down,self))
    }
    /**
     * Handles actions and drawing states for the release event.
     * NOTE: bubbling = true was added to make Stepper class dragable
     */
    override func mouseUpInside(_ event:MouseEvent){
        state = SkinStates.over// :TODO: why in two lines like this?
        setSkinState(getSkinState())
        super.onEvent(ButtonEvent(ButtonEvent.upInside,self))
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event.
     * NOTE: bubbling = true was added to make Stepper class dragable
     */
    override func mouseUpOutside(_ event:MouseEvent){
        state = SkinStates.none
        setSkinState(getSkinState())
        super.onEvent(ButtonEvent(ButtonEvent.upOutside,self))
    }
    /**
     * Convenince
     * NOTE: This method is important to the behaviour of the LeverStepper for instance
     * LEGACY NOTE: This method was turned off temporarily, because it could fire after, this could be resolved by moving the mouseUp call in INteractiveView2 to before the mouseUpInside and mouseUpOutside calls.
     */
    override func mouseUp(_ event:MouseEvent) {
        super.onEvent(ButtonEvent(ButtonEvent.up,self))
    }
    /**
     * New
     * IMPORTANT: we forward the original NSEvent, because NSEvent cant be programaticly created, or at least its difficult, but it is a requsit when promting contxt menu etc
     * We also don't need to forward the rightMouseDOwn NSevent as it can be spawned from the ButtonEvent if needed
     */
    override func rightMouseDown(with event:NSEvent) {
        super.onEvent(ButtonEvent(ButtonEvent.rightMouseDown,self,event))
        //super.rightMouseDown(with: event)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ It could be possible to merge the two skin lines in every event handler some how
 * TODO: ⚠️️ Impliment Focusable and Disablble in this class, the argument that the button must be super simple doesn't hold, if you want a simpler button you can just make an alternate Button class
 * TODO: ⚠️️ If the mouse gets stuck and won't fire the mouseUp after a mouseDown call, then the app should not fail when clicking down again somewhere else, this means we need to centralize the eventListner for mouseUp/mouseDown using global instead of locla could work
 */
class Button:Element {
    /**
     * TODO: ⚠️️ You could synthezis this state by asserting isWithin and isMousePressed. Do this in the future and add it to an extension
     */
    var buttonState:String = ""
    override var skinState:String {
        get {return buttonState + " " + super.skinState}
        set {super.skinState = newValue}
    }
    /**
     * Handles actions and drawing states for the mouseEntered event
     */
    override func mouseOver(_ event:MouseEvent) {
//        Swift.print("Button.mouseOver id: \(id)")
        if NSEvent.pressedMouseButtons == 0 {/*Don't call triggerRollOver if primary mouse button has been pressed, this is to avoid stuck buttons*/
            buttonState = SkinStates.over
            skinState = {self.skinState}()
            super.onEvent(ButtonEvent(ButtonEvent.over,self,event.event))
        }
    }
    /**
     * Handles actions and drawing states for the mouseOut action
     */
    override func mouseOut(_ event:MouseEvent) {
//        Swift.print("Button.mouseOut id: \(id)")
        if NSEvent.pressedMouseButtons == 0 {/*This is to avoid stuck buttons, 0 == no mouse button, 1 == left mouse button, 2 == right mouseButton*/
            buttonState = SkinStates.none
            skinState = {self.skinState}()
            super.onEvent(ButtonEvent(ButtonEvent.out,self,event.event))
        }
    }
    /**
     * Handles actions and drawing states for the down event
     */
    override func mouseDown(_ event:MouseEvent) {
//        Swift.print("mouseDown")
        buttonState = SkinStates.down+" "+SkinStates.over
        skinState = {self.skinState}()
        //super.mouseDown(event)/*passes on the event to the nextResponder, NSView parents etc*/
        super.onEvent(ButtonEvent(ButtonEvent.down,self,event.event))
    }
    /**
     * Handles actions and drawing states for the release event
     * NOTE: bubbling = true was added to make Stepper class dragable
     */
    override func mouseUpInside(_ event:MouseEvent){
//        Swift.print("mouseUpInside")
        buttonState = SkinStates.over// :TODO: ⚠️️ why in two lines like this?
        skinState = {self.skinState}()
        super.onEvent(ButtonEvent(ButtonEvent.upInside,self,event.event))
    }
    /**
     * Handles actions and drawing states for the mouseUpOutside event
     */
    override func mouseUpOutside(_ event:MouseEvent){
        buttonState = SkinStates.none
        skinState = {self.skinState}()
        super.onEvent(ButtonEvent(ButtonEvent.upOutside,self,event.event))
    }
    /**
     * Convenince
     * NOTE: This method is important to the behaviour of the LeverStepper for instance
     * LEGACY NOTE: This method was turned off temporarily, because it could fire after, this could be resolved by moving the mouseUp call in INteractiveView2 to before the mouseUpInside and mouseUpOutside calls.
     */
    override func mouseUp(_ event:MouseEvent) {
        super.onEvent(ButtonEvent(ButtonEvent.up,self,event.event))
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
}

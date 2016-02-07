import Cocoa

/**
 * NOTE: we dont extend Element or InteractiveView here because this view does not need the features that InteractiveView brings
 * TODO: window should have a background element to target. check legacy code to confirm theory
 */
class WindowView:Element{
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        super.resolveSkin()
    }
    /**
     * Returns the class type of the Class instance
     */
    override func getClassType()->String{
        return String(Window)//Window can be targeted via the id so we use Window for all Window subclasses, although this can be overriden in said subclasses
    }
}

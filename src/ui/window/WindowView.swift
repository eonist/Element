import Cocoa

/**
 * NOTE: WindowView needs the interactiveView so that Element has, so that events can propegate to it
 * TODO: WindowView should have a background element to target. check legacy code to confirm theory
 */
class WindowView:Element{
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        super.resolveSkin()
        addSubView(Element(0,0,self,"background"))
    }
    /**
     * Returns the class type of the Class instance
     */
    override func getClassType()->String{
        return String(Window)//Window can be targeted via the id so we use Window for all Window subclasses, although this can be overriden in said subclasses
    }
    func setSize(width: CGFloat, _ height: CGFloat) {
        <#code#>
    }
}

import Cocoa

/**
 * NOTE: we dont extend Element or InteractiveView here because this view does not need the features that InteractiveView brings
 * TODO: window should have a background element to target. check legacy code to confirm theory
 */
class WindowView:InteractiveView2,IElement{
    var id : String?/*css selector id*/
    var parent:IElement?
    var state:String = SkinStates.none
    var skin:ISkin?
    var style:IStyle = Style.clear
    init(_ width: CGFloat, _ height: CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        self.parent = parent
        self.id = id
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        resolveSkin()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * Draws the graphics
     */
    func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        self.addSubview(self.skin as! NSView)
    }
    /**
     * Toggles between css style sheets and have them applied to all Element instances
     */
    func getSkinState() -> String {// :TODO: the skin should have this state not the element object!!!===???
        return state
    }
    /**
     * Sets the current state of the button, which determins the current drawing of the skin
     */
    func setSkinState(state:String) {
        skin!.setSkinState(state)
    }
    /**
     * Returns the class type of the Class instance
     */
    func getClassType()->String{
        return String(Window)//Window can be targeted via the id so we use Window for all Window subclasses, although this can be overriden in said subclasses
    }
}

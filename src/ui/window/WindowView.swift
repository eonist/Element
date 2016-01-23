import Cocoa

/**
 * NOTE: we dont extend Element or InteractiveView here because this view does not need the features that InteractiveView brings
 */
class WindowView:NSVisualEffectView,IElement{
    override var flipped:Bool {return true}/*Organizes your view from top to bottom*/
    var id : String?/*css selector id*/
    var parent:IElement?
    var skinStateValue:String = SkinStates.none/*Cant be named state bc NSVisualEffectView, cant be named skinState bc of objc problems etc*/
    //var state:String = SkinStates.none
    var skin:ISkin?
    var style:IStyle = Style.clear
    override var allowsVibrancy:Bool {return true}
    init(_ width: CGFloat, _ height: CGFloat, _ id:String? = nil) {
        self.id = id;
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        
        

        self.material = NSVisualEffectMaterial.Dark
        self.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        self.state = NSVisualEffectState.Active
        
        
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
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
        return skinStateValue
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

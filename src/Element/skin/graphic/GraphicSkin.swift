import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Graphic is currently an NSVIew, it doesn't have to be. it can be a CALAyer that you attach to skin, SKin it self could be a CALayer, then Text skin would need its own subclass that extends NSView, but they could have a common protocol.
 * TODO: ⚠️️ There needs to be a call to decoratable.initialize() when the skin is updated, check the old project how it was done there. they are done thorugh the size call. and then it calls fill and line basically!?!?
 * NOTE: ⚠️️ Why do we add tracking areas to the parent: because all mouseenter / exit mousemoved should be handled by the element not the skin
 */
class GraphicSkin:Skin{
    override init(_ style:Stylable? = nil, _ state:String = ""){
        super.init(style, state)
    }
    /**
     * Sort of like resolveSkin
     */
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        guard superview != nil else {return}/*this method is fired when you remove a view as well. So to only check for adding you have this assert*/
//        Swift.print("GraphicSkin.resolve")
        
        SkinModifier.float(self)/*Floats the entire element*/
        let depthCount:Int = StyleParser.depthCount(style!)
        decoratables = (0..<depthCount).indices.map{ depth -> GraphicDecoratableKind in
            let decoratable = GraphicSkinUtils.configure(self,depth)/*this call is here because CGContext is only accessible after drawRect is called*/
            addSubview(decoratable.graphic)
            _ = SkinModifier.align(self,decoratable as! Positional,depth)/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit setter method isn't defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
            GraphicSkinModifier.setRotation(decoratable, self, depth)
            decoratable.draw()/*Setup the geometry and init the display process of fill and line*/
            return decoratable
        }
        (parent as? NSView)?.isHidden = SkinParser.display(self) == CSS.Align.none
        
    }
    /**
     * Draws Skin (aka each "decoratable" in the skin)
     */
    override func draw(){
        if hasChanged.size || hasChanged.state || hasChanged.style {
            let depthCount:Int = StyleParser.depthCount(style!)
            for depth in (0..<depthCount){drawDecoratable(depth)}
            (parent as? NSView)?.isHidden = SkinParser.display(self) == CSS.Align.none
        }
        super.draw()/*Sets flags etc*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}



/*
 override func updateTrackingAreas() {
    Swift.print("updateTrackingAreas: " + "\(self)")
 }
 */

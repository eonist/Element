import Cocoa
@testable import Utils
/**
 * TODO: You can't set the frame after you have called the display call on a layer. so you have to set it before.
 * TODO: See if you cant add drawLayer in the LineShape class after all. doesnt delegate work then?
 * TODO: Graphic is currently an NSVIew, it doesnt have to be. it can be a CALAyer that you attach to skin, SKin it self could be a CALayer, then Text skin would need its own subclass that extends NSView, but they could have a common protocol. 
 * TODO: there needs to be a call to decoratable.initialize() when the skin is updated, check the old project how it was done there. they are done thorugh the size call. and then it calls fill and line basically!?!?
 * NOTE: Why do we add tracking areas to the parent: because all mouseenter / exit mousemoved should be handled by the element not the skin
 */
class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        SkinModifier.float(self)/*Floats the entire skin*/
        let depthCount:Int = StyleParser.depthCount(style!)
        decoratables = (0..<depthCount).indices.map{ depth -> IGraphicDecoratable in
            var decoratable = GraphicSkinParser.configure(self,depth)/*this call is here because CGContext is only accessible after drawRect is called*/
            addSubview(decoratable.graphic)
            _ = SkinModifier.align(self,decoratable as! IPositional,depth)/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit setter method isn't defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
            Modifier.rotate(&decoratable, self, depth)
            decoratable.draw()/*Setup the geometry and init the display process of fill and line*/
            return decoratable
        }
    }
    /**
     * Draws Skin (aka each "decoratable" in the skin)
     */
    override func draw(){
        Swift.print("draw")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            let depthCount:Int = StyleParser.depthCount(style!)
            for depth in (0..<depthCount){drawDecoratable(depth)}
        }
        super.draw()/*Sets flags etc*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}


/*override func updateTrackingAreas() {
 Swift.print("updateTrackingAreas: " + "\(self)")
 }*/

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
     * Draws each "layer" in the skin
     */
    override func draw(){
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            let depthCount:Int = StyleParser.depthCount(style!)
            for depth in (0..<depthCount){drawLayer(depth)}
        }
        super.draw()/*Sets flags etc*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
extension GraphicSkin{
    func drawLayer(_ depth:Int){
        if(hasSizeChanged){
            let padding:Padding = Padding()//StylePropertyParser.padding(self,depth);// :TODO: what about margin?<----not sure this is needed, the padding
            Modifier.reSize(decoratables[depth], CGSize(width! + padding.left + padding.right, height! + padding.top + padding.bottom))
        }//Do sizing of the sizable here
        if(hasStateChanged || hasStyleChanged) {updateLayer(&decoratables[depth],depth)}
        _ = SkinModifier.align(self,decoratables[depth] as! IPositional,depth)
        if(hasSizeChanged || hasStateChanged || hasStyleChanged){decoratables[depth].draw()}/*<--you only want to draw once*/
    }
    /**
     * TODO: Don't forget to add fillet, and asset here to , see legacy code
     */
    func updateLayer(_ layer:inout IGraphicDecoratable,_ depth:Int){
        Modifier.applyStyle(&layer,self,depth)
        Modifier.rotate(&layer, self, depth)
        
        if(DecoratorAsserter.hasDecoratable(layer, RectGraphic.self)){
            let padding:Padding = Padding()//StylePropertyParser.padding(self,depth)
            let width:CGFloat = Parser.width(self,depth,padding)
            let height:CGFloat = Parser.height(self,depth,padding)
            (DecoratorParser.decoratable(layer, RectGraphic.self) as! RectGraphic).setSizeValue(CGSize(width,height))/*rect*/// :TODO: should just use the instance setSize function// :TODO: should only be called if the size has actually changed
        }
        if(DecoratorAsserter.hasDecoratable(layer, RoundRectGraphic.self)) {(DecoratorParser.decoratable(layer, RoundRectGraphic.self) as! RoundRectGraphic).fillet = StylePropertyParser.fillet(self,depth)}/*fillet*/
        if(DecoratorAsserter.hasDecoratable(layer, AssetDecorator.self)) {(DecoratorParser.decoratable(layer, AssetDecorator.self) as! AssetDecorator).assetURL = StylePropertyParser.asset(self,depth)/*Svg*/}
        if(DecoratorAsserter.hasDecoratable(layer, DropShadowDecorator.self)) {(DecoratorParser.decoratable(layer, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = StylePropertyParser.dropShadow(self,depth)}/*dropshadow*/
        //decoratable.draw()
    }
}
/**
 * Utils for "layers"
 * TODO: Divide into Parser and Modifier 👈
 */
private class Parser{
    static func width(_ skin:ISkin,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StylePropertyParser.width(skin,depth) ?? skin.width!) + padding.hor// :TODO: only querry this if the size has changed?
    }
    static func height(_ skin:ISkin,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StylePropertyParser.height(skin,depth) ?? skin.height!) + padding.ver// :TODO: only querry this if the size has changed?
    }
}
private class Modifier{
    /**
     * beta
     * TODO: move to DecoratorModifier.swift
     */
    static func reSize(_ sizableDecorator:IGraphicDecoratable,_ size:CGSize){
        (sizableDecorator as! ISizeable).setSizeValue(size)
        //sizableDecorator.draw()
    }
    static func rotate(_ layer:inout IGraphicDecoratable,_ skin:ISkin,_ depth:Int){
        if let rotation:CGFloat = StylePropertyParser.rotation(skin,depth){
            let size:CGSize = (layer as! ISizeable).size
            let pos:CGPoint = (layer as! IPositional).pos
            let rect:CGRect = CGRect(pos, size)
            GraphicModifier.applyRotation(&layer, rotation, rect.center)
        }
    }
    /**
     * Applies style and lineOffset
     */
    static func applyStyle(_ layer:inout IGraphicDecoratable, _ graphicSkin:GraphicSkin,_ depth:Int){
        let fillStyle = StylePropertyParser.fillStyle(graphicSkin,depth)
        let lineStyle = StylePropertyParser.lineStyle(graphicSkin,depth)
        let lineOffsetType = StylePropertyParser.lineOffsetType(graphicSkin,depth)
        _ = GraphicModifier.applyProperties(&layer,fillStyle ,lineStyle ,lineOffsetType)/*color or gradient*/
    }
}


/*override func updateTrackingAreas() {
 Swift.print("updateTrackingAreas: " + "\(self)")
 }*/

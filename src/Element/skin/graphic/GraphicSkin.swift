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
        SkinModifier.float(self)
        let depthCount:Int = StyleParser.depthCount(style!)
        for depth in 0..<depthCount{
            decoratables.append(GraphicSkinParser.configure(self,depth))/*this call is here because CGContext is only accessible after drawRect is called*/
            addSubview(decoratables[depth].graphic)
            _ = SkinModifier.align(self,decoratables[depth] as! IPositional,depth)/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit setter method isn't defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
            decoratables[depth].draw()/*Setup the geometry and init the display process of fill and line*/
        }
    }
    override func draw(){
        Swift.print("draw")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            Swift.print("state size style")
            let depthCount:Int = StyleParser.depthCount(style!)
            //if(hasSizeChanged)
            for depth in 0..<depthCount{
                if(hasSizeChanged){
                    let padding:Padding = Padding()//StylePropertyParser.padding(self,depth);// :TODO: what about margin?<----not sure this is needed, the padding
                    Utils.size(decoratables[depth], CGSize(width! + padding.left + padding.right, height! + padding.top + padding.bottom))
                }//Do sizing of the sizable here
                if(hasStateChanged || hasStyleChanged) {applyProperties(&decoratables[depth],depth)}
                _ = SkinModifier.align(self,decoratables[depth] as! IPositional,depth)
                if(hasSizeChanged || hasStateChanged || hasStyleChanged){decoratables[depth].draw()}/*<--you only want to draw once*/
            }
        }
        super.draw()
    }
    /**
     * TODO: Don't forget to add fillet, and asset here to , see legacy code
     */
    func applyProperties(_ layer:inout IGraphicDecoratable,_ depth:Int){
        Swift.print("applyProperties")
        _ = GraphicModifier.applyProperties(&layer, fillStyle(depth), lineStyle(depth),lineOffsetType(depth))/*color or gradient*/
        if let rotation:CGFloat = StylePropertyParser.rotation(self,depth){
            GraphicModifier.applyRotation(&layer, rotation)
        }else{
            Swift.print("no rotation")
        }
        if(DecoratorAsserter.hasDecoratable(layer, RectGraphic.self)){
            let padding:Padding = Padding()//StylePropertyParser.padding(self,depth)
            let width:CGFloat = (StylePropertyParser.width(self,depth) ?? self.width!) + padding.left + padding.right// :TODO: only querry this if the size has changed?
            let height:CGFloat = (StylePropertyParser.height(self,depth) ?? self.height!) + padding.top + padding.bottom// :TODO: only querry this if the size has changed?
            (DecoratorParser.decoratable(layer, RectGraphic.self) as! RectGraphic).setSizeValue(CGSize(width,height))/*rect*/// :TODO: should just use the instance setSize function// :TODO: should only be called if the size has actually changed
        }
        if(DecoratorAsserter.hasDecoratable(layer, RoundRectGraphic.self)) {(DecoratorParser.decoratable(layer, RoundRectGraphic.self) as! RoundRectGraphic).fillet = StylePropertyParser.fillet(self,depth)}/*fillet*/
        if(DecoratorAsserter.hasDecoratable(layer, AssetDecorator.self)) {(DecoratorParser.decoratable(layer, AssetDecorator.self) as! AssetDecorator).assetURL = StylePropertyParser.asset(self,depth)/*Svg*/}
        if(DecoratorAsserter.hasDecoratable(layer, DropShadowDecorator.self)) {(DecoratorParser.decoratable(layer, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = StylePropertyParser.dropShadow(self,depth)}/*dropshadow*/
        //decoratable.draw()
    }
    /*override func updateTrackingAreas() {
    Swift.print("updateTrackingAreas: " + "\(self)")
    }*/
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
/**
 *
 */
private class Utils{
    /**
     * beta
     * TODO: move to DecoratorModifier.swift
     */
    static func size(_ sizableDecorator:IGraphicDecoratable,_ size:CGSize){
        (sizableDecorator as! ISizeable).setSizeValue(size)
        //sizableDecorator.draw()
    }
}
fileprivate extension GraphicSkin{/*Convenience*/
    func fillStyle(_ depth:Int) -> IFillStyle{
        return StylePropertyParser.fillStyle(self,depth)
    }
    func lineStyle(_ depth:Int) -> ILineStyle?{
        return StylePropertyParser.lineStyle(self,depth)
    }
    func lineOffsetType(_ depth:Int) -> OffsetType {
        return StylePropertyParser.lineOffsetType(self,depth)
    }
}

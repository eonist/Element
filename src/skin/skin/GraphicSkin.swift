import Cocoa
//there needs to be a call to decoratable.initialize() when the skin is updated, check the old project how it was done there. they are done thorugh the size call. and then it calls fill and line basically
/**
 * TODO: you cant set the frame after you have called the display call on a layer. so you have to set it before.
 * TODO: See if you cant add drawLayer in the LineShape class after all. doesnt delegate work then?
 * TODO: Graphic is currently an NSVIew, it doesnt have to be. it can be a CALAyer that you attach to skin, SKin it self could be a CALayer, then Text skin would need its own subclass that extends NSView, but they could have a common protocol. 
 */
class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        let depthCount:Int = StyleParser.depthCount(style!)
        //Swift.print("depthCount: " + "\(depthCount)")
        for (var depth : Int = 0; depth < depthCount; depth++) {
            decoratables.append(GraphicSkinParser.configure(self,depth))/*this call is here because CGContext is only accessible after drawRect is called*/
            addSubview(decoratables[depth].graphic)
            /*decoratable = */SkinModifier.align(self,decoratables[depth] as! IPositional,depth);/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit settermethod isnt defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
            decoratables[depth].draw()/*Setup the geometry and init the display process of fill and line*/
        }
    }
     
    
    override func draw(){
        //Swift.print("GraphicSkin.draw()")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            //Swift.print("hasStateChanged: " + "\(hasStateChanged)")
            //Swift.print("hasSizeChanged: " + "\(hasSizeChanged)")
            //Swift.print("hasStyleChanged: " + "\(hasStyleChanged)")
            let depthCount:Int = StyleParser.depthCount(style!);
            //Swift.print("depthCount: " + "\(depthCount)")
            //if(hasSizeChanged) var padding:Padding2 = StylePropertyParser.padding(this,depth);// :TODO: what about margin?
            for (var depth : Int = 0; depth < depthCount; depth++) {
                
                sizableDecorator.setSizeValue(size)
                sizableDecorator.draw()
                
                if(hasSizeChanged){Utils.size(decoratables[depth] as! SizeableDecorator, CGSize(width!/*+ padding.left + padding.right*/,height!/*+ padding.top + padding.bottom*/))}//do sizing of the sizable here
                if(hasStateChanged || hasStyleChanged) {applyProperties(&decoratables[depth],depth)}
                /*decoratable = */SkinModifier.align(self,decoratables[depth] as! IPositional,depth)/* as! IGraphicDecoratable;*/
            }
        }
        super.draw();
    }
    /**
     * TODO: Dont forget to add fillet, and asset here to , see old code
     */
    func applyProperties(inout decoratable:IGraphicDecoratable,_ depth:Int){
        //Swift.print("GraphicSkin.applyProperties() decoratable: " + "\(decoratable)")
        
        GraphicModifier.applyProperties(&decoratable, StylePropertyParser.fillStyle(self,depth), StylePropertyParser.lineStyle(self,depth), StylePropertyParser.lineOffsetType(self,depth));/*color or gradient*/
        if(DecoratorAsserter.hasDecoratable(decoratable, RectGraphic.self)){
            //Swift.print("has RectGraphic")
            let width:CGFloat = (StylePropertyParser.width(self,depth) ?? self.width!) /*+ padding.left + padding.right*/// :TODO: only querry this if the size has changed?
            let height:CGFloat = (StylePropertyParser.height(self,depth) ?? self.height!) /*+ padding.top + padding.bottom*/// :TODO: only querry this if the size has changed?
            (DecoratorParser.decoratable(decoratable, RectGraphic.self) as! RectGraphic).setSizeValue(CGSize(width,height))/*rect*/// :TODO: should just use the instance setSize function// :TODO: should only be called if the size has actually changed
        }
        if(DecoratorAsserter.hasDecoratable(decoratable, RoundRectGraphic.self)) {/*fillet*/
            (DecoratorParser.decoratable(decoratable, RoundRectGraphic.self) as! RoundRectGraphic).fillet = StylePropertyParser.fillet(self,depth)
        }
        if(DecoratorAsserter.hasDecoratable(decoratable, AssetDecorator.self)) {/*Svg*/
            (DecoratorParser.decoratable(decoratable, AssetDecorator.self) as! AssetDecorator).assetURL = StylePropertyParser.asset(self,depth)
        }
        if(DecoratorAsserter.hasDecoratable(decoratable, DropShadowDecorator.self)) {/*dropshadow*/
            let dropShadow = StylePropertyParser.dropShadow(self,depth)
            StyleParser.describe(self.style!)
            //Swift.print("dropShadow?.color.alphaComponent: " + "\(dropShadow?.color.alphaComponent)")
            (DecoratorParser.decoratable(decoratable, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = dropShadow
        }
        decoratable.draw()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
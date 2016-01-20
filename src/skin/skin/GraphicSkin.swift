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
            /*decoratable = */SkinModifier.align(self,decoratables[depth] as! IPositional);/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit settermethod isnt defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
            decoratables[depth].draw()/*Setup the geometry and init the display process of fill and line*/
        }
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw()")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            let depthCount:Int = StyleParser.depthCount(style!);
            for (var depth : Int = 0; depth < depthCount; depth++) {
                /*if(hasSizeChanged){}*///do sizing of the sizable here
                /*if(hasStateChanged || hasStyleChanged) */applyProperties(decoratables[0]);
                /*decoratable = */SkinModifier.align(self,decoratables[0] as! IPositional)/* as! IGraphicDecoratable;*/
            }
            
        }
        super.draw();
    }
    /**
     * TODO: Dont forget to add fillet, and asset here to , see old code
     */
    func applyProperties(decoratable:IGraphicDecoratable){
        //Swift.print("GraphicSkin.applyProperties()")
        self.decoratables[0] = GraphicModifier.applyProperties(decoratable, StylePropertyParser.fillStyle(self), StylePropertyParser.lineStyle(self), StylePropertyParser.lineOffsetType(self));/*color or gradient*/
        if(DecoratorAsserter.hasDecoratable(decoratable, DropShadowDecorator.self)) {(DecoratorParser.decoratable(decoratable, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = StylePropertyParser.dropShadow(self)}/*dropshadow*/
        decoratable.draw()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
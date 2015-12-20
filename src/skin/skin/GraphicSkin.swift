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
        decoratable = GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
        addSubview(decoratable.graphic)
        /*decoratable = */SkinModifier.align(self,decoratable as! IPositional);/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit settermethod isnt defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
        decoratable.draw()/*Setup the geometry and init the display process of fill and line*/
    
    
        
        //continue here, try to update the layer on button interaction, maybe make a simple example and work from there
        //try to call the update twice. or from aother place.
        //or see history, it seemd to work before
        //just make the example
        
    }
    override func draw(){
        Swift.print("GraphicSkin.draw()")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            applyProperties(decoratable);
            /*decoratable = */SkinModifier.align(self,decoratable as! IPositional)/* as! IGraphicDecoratable;*/
        }
        super.draw();
    }
    /**
     * TODO: Dont forget to add fillet, and asset here to , see old code
     */
    func applyProperties(decoratable:IGraphicDecoratable){
        Swift.print("GraphicSkin.applyProperties()")
        self.decoratable = GraphicModifier.applyProperties(decoratable, StylePropertyParser.fillStyle(self), StylePropertyParser.lineStyle(self), StylePropertyParser.lineOffsetType(self));/*color or gradient*/
        if(DecoratorAsserter.hasDecoratable(decoratable, DropShadowDecorator.self)) {(DecoratorParser.decoratable(decoratable, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = StylePropertyParser.dropShadow(self)}/*dropshadow*/
        decoratable.draw()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
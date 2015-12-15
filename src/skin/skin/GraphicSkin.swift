import Cocoa

class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        decoratable = GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
        /*decoratable = */SkinModifier.align(self,decoratable as! IPositional);/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit settermethod isnt defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/        
        
        let layerA = CALayer()
        layerA.frame = CGRectMake(20, 20, 100, 100);
        layerA.masksToBounds = false//finally it works
        //layerA.position = CGPointMake(10, 10);
        layerA.backgroundColor = NSColor.greenColor().CGColor
        layer!.addSublayer(layerA)
        
        let layerD = CustomLayer(NSColor.blueColor())
        layerD.frame = CGRect(120,120,50,50);
        layerD.display()
        //layerD.masksToBounds = false
        layer!.addSublayer(layerD)
    }
    override func layout() {
        Swift.print("GraphicSkin.layout()")
        
        //decoratable.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
    }
    /*
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("GraphicSkin.drawRect() " + element!.id!)
        decoratable.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
    }
    */
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw()")
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
        //Swift.print("GraphicSkin.applyProperties()")
        self.decoratable = GraphicModifier.applyProperties(decoratable, StylePropertyParser.fillStyle(self), StylePropertyParser.lineStyle(self), StylePropertyParser.lineOffsetType(self));/*color or gradient*/
        if(DecoratorAsserter.hasDecoratable(decoratable, DropShadowDecorator.self)) {(DecoratorParser.decoratable(decoratable, DropShadowDecorator.self) as! DropShadowDecorator).dropShadow = StylePropertyParser.dropShadow(self)}/*dropshadow*/
    }
}
import Cocoa
//there needs to be a call to decoratable.initialize() when the skin is updated, check the old project how it was done there. they are done thorugh the size call. and then it calls fill and line basically
/**
 * TODO: you cant set the frame after you have called the display call on a layer. so you have to set it before.
 */
class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        decoratable = GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
        addSubview(decoratable.graphic)
        /*decoratable = */SkinModifier.align(self,decoratable as! IPositional);/*the argument now becomes a reference to the orgiginal instance, but it also becomes immutable unfortunatly,not to worry, the implicit settermethod isnt defined by swift as mutable, even though it is. I guess indirectly, so the values are mutated on the orginal instance and all is well*/
        //decoratable.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
        
        if(decoratable.getGraphic().fillStyle != nil){decoratable.drawFill()}
        if(decoratable.getGraphic().lineStyle != nil){decoratable.drawLine()}
        
        decoratable.graphic.fillShape.display()/*draw the fileShape*/
        decoratable.graphic.lineShape.display()/*draw the fileShape*/
        
        decoratable.graphic.fillShape.delegate = self
        decoratable.graphic.lineShape.delegate = self
        
        
        //decoratable.graphic.lineShape.display()/*draw the lineShape*/
        /*
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
        */
        
    }
    
    /**
     * This is a delegate handler method
     * TODO: use the other delegate method that doesnt pass in the context, for simpler code!?!
     */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        Swift.print("GraphicSkin.drawLayer(layer,inContext)")
        if(layer === decoratable.graphic.fillShape){
            Swift.print("fillShape")
            decoratable.graphic.fillShape.graphics.context = ctx
            if(decoratable.getGraphic().fillStyle != nil){decoratable.fill()}
            
            //TODO:you only need to call the draw method from here, the fill setting etc can be done in the decoratable classes
            
            //decoratable.graphic.fillShape.graphics.fill(decoratable.graphic.fillStyle!.color)//Stylize the fill
            //Swift.print("inside drawInContext")
            //decoratable.graphic.fillShape.graphics.draw(decoratable.graphic.fillShape.path)//draw everything
            
        }else if(layer === decoratable.graphic.lineShape){
            Swift.print("lineShape")
            decoratable.graphic.lineShape.graphics.context = ctx
            if(decoratable.getGraphic().lineStyle != nil){decoratable.line()}
            
            //TODO:you only need to call the draw method from here, the line setting etc can be done in the decoratable classes
            
            //decoratable.graphic.lineShape.graphics.line(decoratable.graphic.lineStyle!.thickness,decoratable.graphic.lineStyle!.color/*,lineStyle!.lineCap, lineStyle!.lineJoin, lineStyle!.miterLimit*/)//Stylize the line
            //decoratable.graphic.lineShape.graphics.draw(decoratable.graphic.lineShape.path)//draw everything
            
        }
    }
    /*
    override func layout() {
    //Swift.print("GraphicSkin.layout()")
    //decoratable.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
    }
    */
    
    /*
    override func drawRect(dirtyRect: NSRect) {
    //Swift.print("GraphicSkin.drawRect() " + element!.id!)
    
    }
    */
    /**/
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
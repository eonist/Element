import Cocoa
/**
 * Manifesto:
 * 1. This class should only provide access to the graphic instance
 * 2. Contain all the instructions to draw on the graphic
 * NOTE: it should not contain style, size or position
 * TODO: Remove the getGraphics
 */
class GraphicDecoratable:AbstractGraphicDecoratable {
    var decoratable:IGraphicDecoratable
    override var graphic:BaseGraphic {return decoratable.graphic}
    init(_ decoratable:IGraphicDecoratable){
        self.decoratable = decoratable
        super.init()
        graphic.fillShape.delegate = self
        graphic.lineShape.delegate = self
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func initialize(){
        if(getGraphic().fillStyle != nil){fill()}
        if(getGraphic().lineStyle != nil){line()}
    }
    override func draw() {//new
        if(getGraphic().fillStyle != nil){drawFill()}/*setup the fill geometry*/
        if(getGraphic().lineStyle != nil){drawLine()}/*setup the line geometry*/
    }
    
    /**
     * This is a delegate handler method
     * TODO: use the other delegate method that doesnt pass in the context, for simpler code!?!
     */
    func drawLayer(layer: CALayer, inContext ctx: CGContext) {
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
    override func fill(){
        //Swift.print("GraphicDecoratable.fill()")
        beginFill()
        //drawFill()/*this method can be called before beginFill*/
        stylizeFill()
    }
    override func beginFill(){
        decoratable.beginFill()
    }
    override func drawFill(){
        decoratable.drawFill()
    }
    override func stylizeFill(){
        decoratable.stylizeFill()
    }
    override func line(){
        //Swift.print("GraphicDecoratable.line()")
        applyLineStyle()
        //drawLine()/*this method can be called before beginFill*/
        stylizeLine()
    }
    override func applyLineStyle(){
        decoratable.applyLineStyle()
    }
    override func drawLine(){
        decoratable.drawLine()
    }
    override func stylizeLine(){
        decoratable.stylizeLine()
    }
    /**
     * Returns _decoratable.graphic
     * @Note: we use decoratable.graphic to get to the graphics object, regardless of how many layers of decorators above.
     */
    override func getGraphic() -> BaseGraphic{
        return self.decoratable.getGraphic()
    }
    override func getDecoratable()->IGraphicDecoratable{return decoratable}/*new*/
}

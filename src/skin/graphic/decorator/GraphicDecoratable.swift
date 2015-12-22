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
    var selector: ((layer: CALayer, context:CGContext) -> ())?/*this holds any method assigned to it that has its type signature*/
    
    override var graphic:BaseGraphic {return decoratable.graphic}
    
    init(_ decoratable:IGraphicDecoratable){
        self.decoratable = decoratable
        super.init()/*this doesnt init anything, its ust needed to support the setting of self as delegate*/
        graphic.setDelegate(self)/*this is needed in order to be able to retrive the context and use it whithin the decoratable methods, or else the context would reside isolated inside the Graphic.fillShape, and Graphic.lineShape*/
    }
    /**
     * Setup the geometry and init the display process of fill and line
     */
    override func draw() {//new
        Swift.print("GraphicDecoratable.draw()" )
        if(getGraphic().fillStyle != nil){drawFill();graphic.fillShape.setNeedsDisplay();}/*setup the fill geometry*//*draw the fileShape*/
        if(getGraphic().lineStyle != nil){drawLine();graphic.lineShape.setNeedsDisplay();}/*setup the line geometry*//*draw the fileShape*/
    }
    /**
     * This is a delegate handler method
     * NOTE: using the other delegate method "displayLayer" does not provide the context to work with. Trying to get context other ways also fail. This is the only method that works with layer contexts
     * NOTE: this is a delegate method for the shapes in Graphic
     */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        Swift.print("GraphicDecoratable.drawLayer(layer,inContext)")
        selector!(layer: layer,context: ctx)/*call the selector*/
        if(layer === graphic.fillShape){
            //Swift.print("fillShape: ")
            graphic.fillShape.graphics.context = ctx
            if(getGraphic().fillStyle != nil){fill()}
        }else if(layer === graphic.lineShape){
            //Swift.print("lineShape")
            graphic.lineShape.graphics.context = ctx
            if(getGraphic().lineStyle != nil){line()}
        }
    }
    /**
     * Stops implicit animation from happening
     * NOTE: Remember to set the delegate of your CALayer instance to an instance of a class that at least extends NSObject. In this example we extend NSView.
     * NOTE: this is a delegate method for the shapes in Graphic
     * NOTE: this method is also called on every frame of the animation it seems
     */
     /*
     override func actionForLayer(layer: CALayer, forKey event: String) -> CAAction? {
     //Swift.print("actionForLayer")
     return NSNull()
     }
     */
    /*
    func displayLayer(layer: CALayer){
    Swift.print("displayLayer")
    }
    */
    
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
        Swift.print("GraphicDecoratable.drawFill()")
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

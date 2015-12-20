import Foundation
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
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func initialize(){
        if(getGraphic().fillStyle != nil){fill()}
        if(getGraphic().lineStyle != nil){line()}
    }
    override func draw() {//new
        if(getGraphic().fillStyle != nil){drawFill();graphic.fillShape.display();}/*setup the fill geometry*//*draw the fileShape*/
        if(getGraphic().lineStyle != nil){drawLine();graphic.lineShape.display();}/*setup the line geometry*//*draw the fileShape*/
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

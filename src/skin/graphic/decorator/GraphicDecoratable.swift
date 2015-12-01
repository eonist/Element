import Foundation

class GraphicDecoratable:AbstractGraphicDecoratable,IPositional,ISizeable {
    var decoratable:IGraphicDecoratable
    override var graphic:BaseGraphic {return decoratable.graphic}
    var size:CGSize{get{fatalError(errMsg)}set{fatalError(errMsg)}}
    var position:CGPoint{get{fatalError(errMsg)}set{fatalError(errMsg)}}
    //var position:CGPoint{get set}
    init(_ decoratable:IGraphicDecoratable){
        self.decoratable = decoratable
    }
    override func initialize(){
        if(getGraphic().fillStyle != nil){fill()}
        if(getGraphic().lineStyle != nil){line()}
    }
    override func fill(){
        //Swift.print("GraphicDecoratable.fill()")
        beginFill()
        drawFill()
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
        drawLine()
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
}

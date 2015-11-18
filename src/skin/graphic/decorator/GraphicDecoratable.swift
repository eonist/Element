import Foundation

class GraphicDecoratable:AbstractGraphicDecoratable {
    var decoratable:IGraphicDecoratable
    override var graphic:IBaseGraphic {get{return decoratable.graphic}set{decoratable.graphic = newValue}}
    init(_ decoratable:IGraphicDecoratable){
        self.decoratable = decoratable
    }
    override func initialize(){
        fill()
        line()
    }
    override func fill(){
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
        
    }
    override func applyLineStyle(){}
    override func drawLine(){}
    override func stylizeLine(){}
    /**
     * Returns _decoratable.graphic
     * @Note: we use decoratable.graphic to get to the graphics object, regardless of how many layers of decorators above.
     */
    override func getGraphic() -> BaseGraphic{
        return self.decoratable.getGraphic()
    }
}

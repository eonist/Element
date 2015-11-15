import Foundation

class GraphicDecoratable:AbstractGraphicDecoratable {
    var decoratable:IGraphicDecoratable
    init(_ decoratable:IGraphicDecoratable){
        self.decoratable = decoratable
    }
    override func initialize(){
        fill()
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
    override func getGraphic() -> BaseGraphic{
        return self.decoratable.getGraphic()
    }
}

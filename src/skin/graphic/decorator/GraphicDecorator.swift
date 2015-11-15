import Foundation

class GraphicDecorator {
    var decoratable:IGraphicDecorator
    init(_ decoratable:IGraphicDecorator){
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

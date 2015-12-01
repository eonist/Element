import Foundation

class PositionalGraphic:GraphicDecoratable {
    /*var position:CGPoint*/
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.position = position
        super.init(decoratable)
    }
    override func setPosition(position: CGPoint) {
        //Swift.print("PositionalGraphic.setPosition()")
        self.position = position
    }
    override func getPosition() -> CGPoint {
        return position
    }
}


/*class PositionalDecorator:GraphicDecoratable,IPositional{
var position:CGPoint{get{decoratable}set{}}
}*/
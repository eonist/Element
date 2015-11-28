import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    var position:CGPoint
    var y:CGFloat
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.position = position
        super.init(decoratable)
    }
    override func getPositionalGraphic() -> IPositionalGraphic {
        return self
    }
}

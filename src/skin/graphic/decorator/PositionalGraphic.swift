import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    override var position:CGPoint
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.position = position
        super.init(decoratable)
    }
    override func getPositionalGraphic() -> IPositionalGraphic {
        return self
    }
}

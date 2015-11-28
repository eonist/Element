import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    var position:CGPoint
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.position = position
        super.init(decoratable)
    }
}

import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    var x:CGFloat
    var y:CGFloat
    init(_ x:CGFloat = 0,_ y:CGFloat = 0,_ decoratable: IGraphicDecoratable) {
        self.x = x
        self.y = y
        super.init(decoratable)
    }
    override func getPositionalGraphic() -> IPositionalGraphic {
        return self
    }
}

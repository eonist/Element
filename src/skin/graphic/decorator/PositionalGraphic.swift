import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    var x:CGFloat
    var y:CGFloat
    init(x:CGFloat,y:CGFloat,_ decoratable: IGraphicDecoratable) {
        self.x = x
        self.y = y
        super.init(decoratable)
    }
    override func getPositionalGraphic() -> IPositionalGraphic {
        return self
    }
}

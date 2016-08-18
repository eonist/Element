import Foundation

class PositionalGraphic:GraphicDecoratable,IPositional {
    var pos:CGPoint
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.pos = position
        super.init(decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getPosition() -> CGPoint {
        if(pos.x.isNaN){fatalError("x can't be NaN")}
        if(pos.y.isNaN){fatalError("y can't be NaN")}
        return pos
    }
    func setPosition(position: CGPoint) {
        if(position.x.isNaN){fatalError("x can't be NaN")}
        if(position.y.isNaN){fatalError("y can't be NaN")}
        self.pos = position
    }
}
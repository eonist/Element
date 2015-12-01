import Foundation

class PositionalGraphic:PositionalDecorator {
    override var position:CGPoint
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        self.position = position
        super.init(decoratable)
    }
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    /*func getPosition() -> CGPoint {
    return position
    }*/
}

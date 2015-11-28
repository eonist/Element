import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    var width:CGFloat;
    var height:CGFloat;
    init(_ x:CGFloat = 0, _ y:CGFloat = 0, _ width:CGFloat = 100,_ height:CGFloat = 100,_ decoratable: IGraphicDecoratable) {
        self.width = width
        self.height = height
        super.init(x,y,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeable {
    var size:CGSize
    init(position:CGPoint, size:CGSize,_ decoratable: IGraphicDecoratable) {
        self.size = size
        super.init(position,decoratable)
    }
}

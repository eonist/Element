import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    
    var size:CGSize = CGSize()
    init(position:CGPoint, size:CGSize,_ decoratable: IGraphicDecoratable) {
        //self.size = size
        super.init(position,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

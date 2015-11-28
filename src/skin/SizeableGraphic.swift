import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    
    override var size:CGSize{get{return }set{}}
    init(position:CGPoint, size:CGSize,_ decoratable: IGraphicDecoratable) {
        //self.size = size
        super.init(position,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

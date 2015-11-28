import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    var width:CGFloat;
    var height:CGFloat;
    
    //continue here:
    //use cgsize and cgpoint as the variables and then provide convenince init for the width,height,x,y props
    //implement size and point variables for easy access aswell that can set and get
    
    
    init(_ x:CGFloat = 0, _ y:CGFloat = 0, _ width:CGFloat = 100,_ height:CGFloat = 100,_ decoratable: IGraphicDecoratable) {
        self.width = width
        self.height = height
        super.init(x,y,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

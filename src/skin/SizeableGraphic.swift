import Foundation
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    override var size:CGSize
    
    //continue here:
    //use cgsize and cgpoint as the variables and then provide convenince init for the width,height,x,y props
    //implement size and point variables for easy access aswell that can set and get
    
    //Do the bellow!!!!
    //actually you could solve all this Sizable and positionable nonsence by adding everything to BaseGraphic again and just set it getters for classes that cant be set and setters and getters for all others
    //remove the getPositional etc
    
    init(position:CGPoint, size:CGSize,_ decoratable: IGraphicDecoratable) {
        self.size = size
        super.init(position,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

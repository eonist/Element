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
    
    //Do the bellow!!!!
    //actually you could solve all this Sizable and positionable nonsence by adding everything to BaseGraphic again and just set it getters for classes that cant be set and setters and getters for all others
    
    
    init(_ x:CGFloat = 0, _ y:CGFloat = 0, _ width:CGFloat = 100,_ height:CGFloat = 100,_ decoratable: IGraphicDecoratable) {
        self.width = width
        self.height = height
        super.init(x,y,decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}

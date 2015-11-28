import Foundation

class PositionalGraphic:GraphicDecoratable {
    var x:CGFloat = 0
    var y:CGFloat = 0
    /**
     *
     */
    override func setPosition(position:CGPoint){
        x = position.x
        y = position.y
        //path = CGPathModifier.translate(&path,position.x,position.y)//Transformations
        //linePath = CGPathModifier.translate(&linePath,position.x,position.y)//Transformations
    }
}

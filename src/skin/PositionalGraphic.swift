import Foundation

class PositionalGraphic:GraphicDecoratable {
    var x:CGFloat = 0
    var y:CGFloat = 0
    init(_ x:CGFloat = 0,_ y:CGFloat = 0,_ decoratable: IGraphicDecoratable) {
        self.x = x
        self.y = y
        super.init(decoratable)
    }
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

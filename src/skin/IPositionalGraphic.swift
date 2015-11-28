import Foundation

protocol IPositionalGraphic {
    var x:CGFloat{get set}
    var y:CGFloat{get set}
    func getGraphic()->Graphic
}
extension IPositionalGraphic{
    /**
     * TODO: remove the x and y values from this class, some graphics may not have a natural x and y pos like LineGraphic or PathGraphic
     */
    func setPosition(position:CGPoint){
        getGraphic().setPosition(position)
        getGraphic().y = position.y
        //path = CGPathModifier.translate(&path,position.x,position.y)//Transformations
        //linePath = CGPathModifier.translate(&linePath,position.x,position.y)//Transformations
    }
}
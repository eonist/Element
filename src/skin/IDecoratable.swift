import Foundation

protocol IDecoratable{
    var decoratable:IDecoratable{get}
    func fill()
    func line()
    func drawFill()
    func drawLine()
    func beginFill()
    func applyLineStyle(graphics:Graphics,_ lineStyle:ILineStyle)
    func getShape()-> Shape/*Dont revert to IGraphic here*/
}
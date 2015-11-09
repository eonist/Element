import Foundation

protocol IDecoratable{
    var decoratable:IDecoratable{get}
    func fill()
    func line()
    func drawFill()
    func drawLine()
    func clear()
    func clearLine()
    func beginFill()
    func applyLineStyle(graphics:Graphics,_ lineStyle:ILineStyle)
    func endFill()
    func getGraphic()-> Graphic/*Dont revert to IGraphic here*/

}
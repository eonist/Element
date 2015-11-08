import Foundation

protocol IDecoratable{
    func getGraphic()-> Graphic
    func fill()
    func line()
    func drawFill()
    func drawLine()
    func clear()
    func clearLine()
    func beginFill()
    func applyLineStyle(graphics:Graphics,lineStyle:ILineStyle)
    func endFill()
}
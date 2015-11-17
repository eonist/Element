import Foundation
/**
 * These are the methods the GraphicDecoratable must implement
 * Differs from IBaseGraphic in that IBaseGraphic has some variables that the decoratables isnt dependent on when it comes to the creation procedure
 */
protocol IGraphicDecoratable {
    var graphic:IBaseGraphic{get}
    func getGraphic() -> BaseGraphic/*Dont revert this variable to a protocol*/
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
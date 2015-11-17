import Foundation

protocol IGraphicDecoratable {
    var graphic:IBaseGraphic{get}
    func getGraphic() -> BaseGraphic/*Dont revert this variable to a protocol*/
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
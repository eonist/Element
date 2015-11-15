import Foundation

protocol IGraphicDecoratable {
    func getGraphic() -> BaseGraphic/*Dont revert this variable to a protocol*/
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
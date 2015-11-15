import Foundation

protocol IGraphicDecoratable {
    func getGraphic() -> BaseGraphic
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
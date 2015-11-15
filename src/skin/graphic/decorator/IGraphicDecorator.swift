import Foundation

protocol IGraphicDecorator {
    func getGraphic() -> BaseGraphic
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    var graphic:IBaseGraphic {fatalError("Must be overridden in subClass")}
    func initialize(){}
    func fill(){}
    func line(){}
    func applyLineStyle(){}
    func drawLine(){}
    func stylizeLine(){}
    func beginFill(){}
    func drawFill(){}
    func stylizeFill(){}
    func getGraphic() -> BaseGraphic{fatalError("Must be overridden in subClass")}
}
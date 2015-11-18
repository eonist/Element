import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    var graphic:IBaseGraphic {get {fatalError("Must be overridden in subClass")} set{fatalError("Must be overridden in subClass")}}
    func getGraphic() -> BaseGraphic{fatalError("Must be overridden in subClass")}
    func initialize(){}
    /*Fill*/
    func fill(){}
    func beginFill(){}
    func drawFill(){}
    func stylizeFill(){}
    /*Line*/
    func line(){}
    func applyLineStyle(){}
    func drawLine(){}
    func stylizeLine(){}
}
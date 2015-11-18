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
    func beginFill(){fatalError("Must be overridden in subClass")}
    func drawFill(){fatalError("Must be overridden in subClass")}
    func stylizeFill(){fatalError("Must be overridden in subClass")}
    /*Line*/
    func line(){}
    func applyLineStyle(){fatalError("Must be overridden in subClass")}
    func drawLine(){fatalError("Must be overridden in subClass")}
    func stylizeLine(){fatalError("Must be overridden in subClass")}
}
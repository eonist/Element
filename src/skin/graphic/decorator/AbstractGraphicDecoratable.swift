import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    var graphic:BaseGraphic {fatalError("Must be overridden in subClass")}//dont revert to IBaseGraphic
    func getGraphic() -> BaseGraphic{fatalError("Must be overridden in subClass")}
    func initialize(){
        if(getGraphic().fillStyle != nil){fill()}
        if(getGraphic().lineStyle != nil){line()}
    }
    /*Fill*/
    func fill(){
        beginFill()
        drawFill()
        stylizeFill()
    }
    func beginFill(){fatalError("Must be overridden in subClass")}
    func drawFill(){fatalError("Must be overridden in subClass")}
    func stylizeFill(){fatalError("Must be overridden in subClass")}
    /*Line*/
    func line(){
        applyLineStyle()
        drawLine()
        stylizeLine()
    }
    func applyLineStyle(){fatalError("Must be overridden in subClass")}
    func drawLine(){fatalError("Must be overridden in subClass")}
    func stylizeLine(){fatalError("Must be overridden in subClass")}
}
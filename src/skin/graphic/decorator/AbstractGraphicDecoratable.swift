import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    var graphic:BaseGraphic {fatalError("Must be overridden in subClass")}//dont revert to IBaseGraphic, also this is only a getter since you cant override variable setters
    func getGraphic() -> BaseGraphic{fatalError("Must be overridden in subClass")}
    func getPositionalGraphic()-> IPositionalGraphic{fatalError("Must be overridden in subClass")}
    func getSizeableGraphic()-> ISizeableGraphic{fatalError("Must be overridden in subClass")}
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
    /**/
    var size:CGSize{fatalError("Must be overridden in subClass")}//this is only a getter since you cant override variable setters
    var position:CGPoint{fatalError("Must be overridden in subClass")}//this is only a getter since you cant override variable setters
    func setSize(size:CGSize){}
}
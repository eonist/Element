import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    let errMsg:String = "Must be overridden in subClass"
    var graphic:BaseGraphic {fatalError(errMsg)}//dont revert to IBaseGraphic, also this is only a getter since you cant override variable setters
    func getGraphic() -> BaseGraphic{fatalError(errMsg)}
    func getPositionalGraphic()-> IPositionalGraphic{fatalError(errMsg)}
    func getSizeableGraphic()-> ISizeableGraphic{fatalError(errMsg)}
    func initialize(){}
    /*Fill*/
    func fill(){}
    func beginFill(){fatalError(errMsg)}
    func drawFill(){fatalError(errMsg)}
    func stylizeFill(){fatalError(errMsg)}
    /*Line*/
    func line(){}
    func applyLineStyle(){fatalError(errMsg)}
    func drawLine(){fatalError(errMsg)}
    func stylizeLine(){fatalError(errMsg)}
    /**/
    var size:CGSize{fatalError(errMsg)}//this is only a getter since you cant override variable setters
    var position:CGPoint{fatalError(errMsg)}//this is only a getter since you cant override variable setters
    func setSize(size:CGSize){fatalError(errMsg)}
    func setPosition(position:CGPoint){fatalError(errMsg)}
}
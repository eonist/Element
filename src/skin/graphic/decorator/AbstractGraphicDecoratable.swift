import Foundation
/*
 * The AbstractDecorator has all the decorator methods
 */
class AbstractGraphicDecoratable:IGraphicDecoratable{
    let errMsg:String = "Must be overridden in subClass"
    var graphic:BaseGraphic {fatalError(errMsg)}//dont revert to IBaseGraphic
    func getGraphic() -> BaseGraphic{fatalError(errMsg)}
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
    func getSize()->CGSize {fatalError(errMsg)}//all shapes has a size
    func getPosition()->CGPoint{fatalError(errMsg)}//all shapes has a position
    func setSize(size:CGSize){fatalError(errMsg)}//not all shapes has sizes that can be set
    func setPosition(position:CGPoint){fatalError(errMsg)}//not all shapes has positions that can be set
}
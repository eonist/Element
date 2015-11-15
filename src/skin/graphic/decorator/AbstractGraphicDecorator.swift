import Foundation
/*
* The AbstractDecorator has all the decorator methods
*/
class AbstractGraphicDecorator:IGraphicDecorator{
    func initialize(){
    }
    func fill(){
    }
    func beginFill(){
    }
    func drawFill(){
    }
    func stylizeFill(){
    }
    func getGraphic() -> BaseGraphic{
        fatalError("Must be overridden in subClass")
    }
}
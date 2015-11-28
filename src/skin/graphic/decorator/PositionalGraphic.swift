import Foundation

class PositionalGraphic:GraphicDecoratable,IPositionalGraphic {
    var x:CGFloat = 0
    var y:CGFloat = 0
    override func getPositionalGraphic() -> IPositionalGraphic {
        return self
    }
}

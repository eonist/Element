import Foundation
/**
 * NOTE: It isnt ideal that you have to extend PositionalDecorator instead of simply GraphicDecorable, but in the spirit of moving on we keep it as is
 */
class DropShadowDecorator:PositionalDecorator{
    var dropShadow:DropShadow
    init(_ decoratable: IGraphicDecoratable,_ dropShadow:DropShadow) {
        self.dropShadow = dropShadow
        super.init(decoratable)
    }
    override func fill() {
        Swift.print("DropShadowDecorator.fill()")
        graphic.graphics.dropShadow = dropShadow;
        Swift.print(graphic.graphics.dropShadow)
        super.fill()
    }
}
import Foundation
/**
 * NOTE: It isnt ideal that you have to extend PositionalDecorator instead of simply GraphicDecorable, but in the spirit of moving on we keep it as is
 */
class DropShadowDecorator:PositionalDecorator{
    var dropShadow:DropShadow?
    init(_ decoratable: IGraphicDecoratable,_ dropShadow:DropShadow?) {
        self.dropShadow = dropShadow
        super.init(decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func fill() {
        //Swift.print("DropShadowDecorator.fill()")
        graphic.fillShape.graphics.dropShadow = dropShadow;
        graphic
        //Swift.print(graphic.graphics.dropShadow)
        super.fill()
    }
}
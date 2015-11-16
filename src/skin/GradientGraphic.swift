import Cocoa

class GradientGraphic:GraphicDecoratable {
    override func beginFill(){
        graphic.fillStyle is GradientFillStyle
        ObjectAsserter.ofClass(, ) ? FillStyleModifier.beginGradientFill(graphic.fillShape.graphics, GradientFillStyle(graphic.fillStyle).gradient) : decoratable.beginFill();/*If there is no GradienFillStyle then beginFill with with whatever is in the decoratable*/;
    }
}

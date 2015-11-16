import Cocoa

class GradientGraphic:GraphicDecoratable {
    override func beginFill(){
        if(getGraphic().fillStyle.dynamicType is GradientFillStyle.Type){
            FillStyleModifier.beginGradientFill(getGraphic().graphics, GradientFillStyle(getGraphic().fillStyle,NSColor.clearColor()).gradient)
        }
    }
}

import Cocoa

class GradientGraphic:GraphicDecoratable {
    override func beginFill(){
        if(getGraphic().fillStyle.dynamicType is GradientFillStyle.Type){
            FillStyleModifier.beginGradientFill(getGraphic().graphics, (getGraphic().fillStyle as! GradientFillStyle).gradient)
        }
    }
}

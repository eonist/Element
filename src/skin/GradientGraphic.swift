import Cocoa
/*
* @Note: Use FillStyleUtils.beginGradientFill(_gradientRect.graphic.graphics, _gradient); if you need to modifiy
* @Note there may not be a need to include a getter function for the fillStyle, since if this instance is edited with a Utility class the new fillstyle is applied but not stored in _fillStyle, same goes for lineStyle
*/
class GradientGraphic:GraphicDecoratable {
    override func beginFill(){
        if(getGraphic().fillStyle!.dynamicType is GradientFillStyle.Type){
            FillStyleModifier.beginGradientFill(getGraphic().graphics, (getGraphic().fillStyle as! GradientFillStyle).gradient)
        }else{
            Swift.print(String(getGraphic().fillStyle))
            fatalError("NOT CORRECT fillStyle")
        }
    }
    override func applyLineStyle() {
        
    }
}

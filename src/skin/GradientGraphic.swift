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
    /**
     * // :TODO: could possibly be renamed to applyGradientLinestyle
     */

    override func applyLineStyle() {
        
        /*
        if(lineStyle != nil) {/*updates only if lineStyle of class LineStyle*/
            graphics.line(lineStyle!.thickness, lineStyle!.color, lineStyle!.lineCap, lineStyle!.lineJoin, lineStyle!.miterLimit)
        }
        */
        
        if(getGraphic().lineStyle!.dynamicType is GradientLineStyle.Type){
            LineStyleModifier.lineGradientStyle(graphic.graphics, (graphic.lineStyle as! GradientLineStyle).gradient);//Updates only if _lineGradient is not null, and _lineGradient.colors[0] and (_lineGradient.colors[1] are valid colors)
        }else{
            Swift.print(String(getGraphic().fillStyle))
            fatalError("NOT CORRECT lineStyle")
        }
        
    }
}

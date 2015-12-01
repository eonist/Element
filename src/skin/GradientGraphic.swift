import Cocoa
/*
* @Note: Use FillStyleUtils.beginGradientFill(_gradientRect.graphic.graphics, _gradient); if you need to modifiy
* @Note there may not be a need to include a getter function for the fillStyle, since if this instance is edited with a Utility class the new fillstyle is applied but not stored in _fillStyle, same goes for lineStyle
*/
class GradientGraphic:SizeableGraphic {
    /**
     *
     */
    override func beginFill(){
        //Swift.print("GradientGraphic.beginFill()")
        if(getGraphic().fillStyle!.dynamicType is GradientFillStyle.Type){
            getGraphic().graphics.gradientFill((getGraphic().fillStyle as! GradientFillStyle).gradient)
        }else{super.beginFill()}//fatalError("NOT CORRECT fillStyle")
            
        
    }
    /**
     * // :TODO: could possibly be renamed to applyGradientLinestyle
     */
    override func applyLineStyle() {
        //Swift.print("GradientGraphic.applyLineStyle()")
        super.applyLineStyle()//call the BaseGraphic to set the stroke-width, cap, joint etc
        if(getGraphic().lineStyle!.dynamicType is GradientLineStyle.Type){
            //Swift.print("lineStyle is GradientLineStyle")
            LineStyleModifier.lineGradientStyle(graphic.graphics, (graphic.lineStyle as! GradientLineStyle).gradient);//Updates only if _lineGradient is not null, and _lineGradient.colors[0] and (_lineGradient.colors[1] are valid colors)
        }//else{fatalError("NOT CORRECT lineStyle")}
    }
}

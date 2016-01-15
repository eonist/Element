import Cocoa
/*
 * @Note: Use FillStyleUtils.beginGradientFill(_gradientRect.graphic.graphics, _gradient); if you need to modifiy
 * @Note there may not be a need to include a getter function for the fillStyle, since if this instance is edited with a Utility class the new fillstyle is applied but not stored in _fillStyle, same goes for lineStyle
 */

//TODO: look into making ISIzeableGraohic and IPositionalGraphic again that extends the functionality you need but doesnt have the init stuff

class GradientGraphic:PositionalDecorator/*<--recently changed from GraphicDecoratable*/ {//TODO: probably should extend SizeableDecorator, so that we can resize the entire Decorator structure
    /**
     *
     */
    override func beginFill(){
        Swift.print("GradientGraphic.beginFill()")
        if(graphic.fillStyle!.dynamicType is GradientFillStyle.Type){
            let gradient = (graphic.fillStyle as! GradientFillStyle).gradient
            let points:(start:CGPoint,end:CGPoint) = GradientBoxUtils.points(boundingBox, gradient.rotation) /*GradientBox*/
            graphic.fillShape.graphics.gradientFill(gradient)
        }else{super.beginFill()}//fatalError("NOT CORRECT fillStyle")
    }
    /**
     * // :TODO: could possibly be renamed to applyGradientLinestyle, as it needs to override it cant be renamed
     */
    override func applyLineStyle() {
        //Swift.print("GradientGraphic.applyLineStyle()")
        super.applyLineStyle()/*call the BaseGraphic to set the stroke-width, cap, joint etc*/
        if(getGraphic().lineStyle!.dynamicType is GradientLineStyle.Type){//<--the dynamicType may not be needed
            //Swift.print("lineStyle is GradientLineStyle")
            LineStyleModifier.lineGradientStyle(graphic.lineShape.graphics, (graphic.lineStyle as! GradientLineStyle).gradient);//Updates only if _lineGradient is not null, and _lineGradient.colors[0] and (_lineGradient.colors[1] are valid colors)
        }//else{fatalError("NOT CORRECT lineStyle")}
    }
}
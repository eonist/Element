import Cocoa
/*
 * @Note: Use FillStyleUtils.beginGradientFill(_gradientRect.graphic.graphics, _gradient); if you need to modifiy
 * @Note there may not be a need to include a getter function for the fillStyle, since if this instance is edited with a Utility class the new fillstyle is applied but not stored in _fillStyle, same goes for lineStyle
 * TODO: why isnt this a decorator? if you find the answere then add to a NOTE in this description
 * //TODO: look into making ISIzeableGraohic and IPositionalGraphic again that extends the functionality you need but doesnt have the init stuff
 */
class GradientGraphic:SizeableDecorator/*<--recently changed from GraphicDecoratable, and then changed to SizeableDec..was positionalDec etc, then changed back to positional, then changed to SizeableDecorator again after a bug surfaced*/ {//TODO: probably should extend SizeableDecorator, so that we can resize the entire Decorator structure
    /**
     *
     */
    override func beginFill(){
        //Swift.print("GradientGraphic.beginFill()")
        if(graphic.fillStyle is IGradientFillStyle){
            let gradient = (graphic.fillStyle as! GradientFillStyle).gradient
            let boundingBox:CGRect = CGPathGetBoundingBox(graphic.fillShape.path) /*creates a boundingbox derived from the bounds of the path*/
            //Swift.print("GradientGraphic.boundingBox: " + "\(boundingBox)")
            let graphicsGradient:IGraphicsGradient = Utils.graphicsGradient(boundingBox, gradient)
            graphic.fillShape.graphics.gradientFill(graphicsGradient)
        }else{
            //Swift.print("super.beginFill()")
            super.beginFill()/*do regular color fill*/
        }//fatalError("NOT CORRECT fillStyle")
    }
    /**
     * NOTE: we could renamed this method to applyGradientLinestyle, but as it needs to override it cant be renamed!
     */
    override func applyLineStyle() {
        //Swift.print("GradientGraphic.applyLineStyle()")
        super.applyLineStyle()/*call the BaseGraphic to set the stroke-width, cap, joint etc*/
        if(getGraphic().lineStyle is IGradientLineStyle){
            let gradient:IGradient = (graphic.lineStyle as! GradientLineStyle).gradient
            var boundingBox:CGRect = CGPathGetBoundingBox(graphic.lineShape.path) // this method can be moved up one level if its better for performance, but wait untill you impliment matrix etc
            boundingBox = boundingBox.outset(graphic.lineStyle!.thickness/2, graphic.lineStyle!.thickness/2)/*Outset the boundingbox to cover the entire stroke*/
            
            //TODO: the above isn't totally correct, use the outline-stroke method and then get the boundingbox from that, think different caps etc
            
            let graphicsGradient:IGraphicsGradient = Utils.graphicsGradient(boundingBox, gradient)
            graphic.lineShape.graphics.gradientLine(graphicsGradient)
        }//else{fatalError("NOT CORRECT lineStyle")}
    }
}
private class Utils{
    /**
     *
     */
    class func graphicsGradient(boundingBox:CGRect,_ gradient:IGradient)->IGraphicsGradient{
        if(gradient is LinearGradient){
            //Swift.print("gradient.rotation: " + "\(gradient.rotation)")
            let points:(start:CGPoint,end:CGPoint) = GradientBoxUtils.points(boundingBox, gradient.rotation) /*GradientBox*/
            //Swift.print("points.start: " + "\(points.start)")
            //Swift.print("points.end: " + "\(points.end)")
            return LinearGraphicsGradient(gradient.colors,gradient.locations,nil,points.start,points.end)
            
        }else if(gradient is RadialGradient){
            let rg = RadialGradientUtils.radialGradient(boundingBox,gradient as! RadialGradient)/*Creates and configs the radial gradient*/
            return RadialGraphicsGradient(gradient.colors,gradient.locations,rg.transform,rg.startCenter,rg.endCenter,rg.startRadius,rg.endRadius)
        }else{/*future support for Canonical gradient*/
            fatalError("this type is not supported: " + "\(gradient)")
        }
    }
}
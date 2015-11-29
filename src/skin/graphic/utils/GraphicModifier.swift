import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(inout decoratable:IGraphicDecoratable,_ fillStyle:IFillStyle,_ lineStyle:ILineStyle,_ offsetType:OffsetType)->IGraphicDecoratable {
        decoratable.graphic.fillStyle = fillStyle;
        decoratable.graphic.lineStyle = lineStyle;
        decoratable.graphic.lineOffsetType = offsetType;
        return decoratable;
    }
    /**
     * Finalizes the fill style to the path
     * NOTE: before it was all bundeled together in the size method, now its move here
     */
    class func stylize(path:CGPath, _ graphics:Graphics){
        //path.fill()
        //path.stroke()
        graphics.draw(path)//draw everything
        graphics.stopFill()
    }
    /**
     * Finalizes the stroke style to the path
     * NOTE: before it was all bundeled together in the size method, now its move here
     */
    class func stylizeLine(path:CGPath, _ graphics:Graphics){
        graphics.draw(path)//draw everything
        graphics.stopStroke()
    }
}
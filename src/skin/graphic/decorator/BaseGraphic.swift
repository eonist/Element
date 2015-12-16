import Cocoa
/*
* The BaseGraphic class is an Element DataObject class that holds the lineshape, lineStyle and fillStyle
* // :TODO: possibly get rid of the setters for the fillStyle and Line style and use implicit setFillStyle and setLineStyle?
* NOTE: We dont need a line mask, just subclass the Graphics class so it supports masking of the line aswell (will require some effort)
*/
class BaseGraphic :Graphic,IGraphicDecoratable{/*was extending AbstractGraphicDecoratable*/
    //lazy var graphics:Graphics = Graphics()
    
    var graphic:BaseGraphic {return self}
    //var fillStyle:IFillStyle?
    //var lineStyle:ILineStyle?
    //var lineOffsetType:OffsetType
    //var path:CGMutablePath = CGPathCreateMutable()
    //var linePath:CGMutablePath = CGPathCreateMutable()
    /*
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType = OffsetType()) {
        //self.fillStyle = fillStyle
        //self.lineStyle = lineStyle
        //self.lineOffsetType = lineOffsetType
        super.init()
    }
    */
    
    /**
     * TODO: color cant be uint since uint cant be NaN, use Double, 
     * TODO:  check if cgfloat can be NaN?
     */
    func beginFill(){
        if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {/*Updates only if fillStyle is of class FillStyle*/
            //Swift.print("BaseGraphic.beginFill() fillStyle!.color: " + String(fillStyle!.color))
            fillShape.graphics.fill(fillStyle!.color)//Stylize the fill
        }
    }
    func stylizeFill(){
        GraphicModifier.stylize(fillShape.path,fillShape.graphics)//realize style on the graphic
    }
    /**
     *
     */
    func applyLineStyle() {
        //Swift.print("BaseGraphic.applyLineStyle() " + String(lineStyle != nil))
        //Swift.print("lineStyle!.color: " + String(lineStyle!.color))
        if(lineStyle != nil) {/*updates only if lineStyle of class LineStyle*/
            lineShape.graphics.line(lineStyle!.thickness, lineStyle!.color, lineStyle!.lineCap, lineStyle!.lineJoin, lineStyle!.miterLimit)
        }
    }
    func stylizeLine(){
        //Swift.print("BaseGraphic.stylizeLine()")
        GraphicModifier.stylizeLine(lineShape.path,lineShape.graphics)//realize style on the graphic
    }
    
    func getGraphic()->BaseGraphic{
        return self
    }
    func getDecoratable()->IGraphicDecoratable{return self}/*new*/
}

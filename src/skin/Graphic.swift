import Cocoa
/*
* The graphic class is an Element DataObject class that holds the lineshape, lineStyle and fillStyle
* // :TODO: possibly get rid of the setters for the fillStyle and Line style and use implicit setFillStyle and setLineStyle?
* NOTE: We dont need a line mask, just subclass the Graphics class so it supports masking of the line aswell (will require some effort)
*/




//continue here: extend IDecoratable
//and rectGraphic should extend Decoratable
//move all code in RectGraphic to Graphic that has to do with drawing and styling etc. 
//RectGraphic should only consern it self with making a square path this way you can have CircleGraphic EllipseGraphic etc.
//That are also only concerning themselfs with just making the path etc. less code!




class Graphic:IGraphic,IDecoratable{//this will extend Graphics in the future or just have it
    var fillStyle:IFillStyle?
    var lineStyle:ILineStyle?
    var graphics:Graphics
    var path:CGPath = CGPathCreateMutable()
    //var linePath:CGPath = CGPathCreateMutable()
    //var lineOffsetType:OffsetType
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil/*, _ lineOffsetType:OffsetType = OffsetType()*/){
        self.fillStyle = fillStyle
        self.lineStyle = lineStyle
        /*self.lineOffsetType = lineOffsetType*/
        graphics = Graphics()
        
    }
    func initialize(){
        fill();
        //line();
    }
    func fill() {
        //CGContextSaveGState(graphics.context);
        beginFill();
        drawFill();
        //CGContextRestoreGState(graphics.context);
    }
    func line(){
        fatalError("NOT IMPLEMENTED YET")
        //applyLineStyle(self,lineStyle);
        //drawLine();
    }
    func beginFill() {
        if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {
            GraphicModifier.applyProperties(graphics, fillStyle!/*, lineStyle*/)//apply style
        }
    }
    /**
     * // :TODO: does this function need arguments?
     */
    func applyLineStyle(graphics:Graphics,_ lineStyle:ILineStyle) {
        /*
        if(lineStyle != nil) {
        //apply lineStyle here /*updates only if lineStyle of class LineStyle*/
        }
        */
    }
    func drawFill() {
        Swift.print("Graphic.drawFill()")
        GraphicModifier.stylize(path,graphics)//realize style on the graphic
    }
    func drawLine() {
        if(lineStyle != nil){
            //do line drawing here, keep in mind line mask
        }
    }
    func getGraphic()-> Graphic{/*Dont revert to IGraphic here*/
        //fatalError("NOT IMPLEMENTED YET")
        return self
    }
    func setPosition(position:CGPoint){
        //TODO:translate the graphics to position
        CGPathModifier.translate(&path,position.x,position.y)//Transformations
    }
    func setProperties(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil){// :TODO: remove this and replace with setLineStyle and setFillStyle ?
        self.fillStyle = fillStyle;
        self.lineStyle = lineStyle;
    }
}
import Cocoa
/*
 * The graphic class is an Element DataObject class that holds the lineshape, lineStyle and fillStyle
 * // :TODO: possibly get rid of the setters for the fillStyle and Line style and use implicit setFillStyle and setLineStyle?
 * NOTE: We dont need a line mask, just subclass the Graphics class so it supports masking of the line aswell (will require some effort)
 */

//rename to shape, extend graphic, that extends nsview, to clear simply use needsDisplay and everything will be drawn again,

class Shape:Graphic,IShape,IDecoratable{//this will extend Graphics in the future or just have it
    var fillStyle:IFillStyle?
    var lineStyle:ILineStyle?
    var path:CGPath = CGPathCreateMutable()
    var decoratable:IDecoratable{return self}
    //var linePath:CGPath = CGPathCreateMutable()
    //var lineOffsetType:OffsetType
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil/*, _ lineOffsetType:OffsetType = OffsetType()*/){
        self.fillStyle = fillStyle
        self.lineStyle = lineStyle
        /*self.lineOffsetType = lineOffsetType*/
        super.init()
        fill();
        //line();
    }
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func fill() {
        beginFill();
        drawFill();
    }
    /**
     *
     */
    func clear(){
        Swift.print("Shape.clear()")
        self.needsDisplay = true//initiates a call to drawRect()
        //drawRect(NSMakeRect(0, 0, 100, 100))
        Swift.print("Shape.clear() post needsDisplay")
    }
    /*
     *
     */
    func line(){
        fatalError("NOT IMPLEMENTED YET")
        //applyLineStyle(self,lineStyle);
        //drawLine();
    }
    func beginFill() {
        if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {
            let randomColor:NSColor = ColorUtils.randomColor()
            let fillStyle = FillStyle(randomColor)
            GraphicModifier.applyProperties(graphics, fillStyle/*, lineStyle*/)//apply style
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
        Swift.print("Shape.drawFill()")
        GraphicModifier.stylize(path,graphics)//realize style on the graphic
    }
    func drawLine() {
        if(lineStyle != nil){
            //do line drawing here, keep in mind line mask
        }
    }
    func getShape()-> Shape{/*Dont revert to IGraphic here*/
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
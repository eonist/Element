import Cocoa
/*
* The BaseGraphic class is an Element DataObject class that holds the lineshape, lineStyle and fillStyle
* // :TODO: possibly get rid of the setters for the fillStyle and Line style and use implicit setFillStyle and setLineStyle?
* NOTE: We dont need a line mask, just subclass the Graphics class so it supports masking of the line aswell (will require some effort)
*/
class BaseGraphic :AbstractGraphicDecoratable,IBaseGraphic{
    var fillStyle:IFillStyle?
    var lineStyle:ILineStyle?
    lazy var graphics:Graphics = Graphics()
    var path:CGPath = CGPathCreateMutable()
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil/*, _ lineOffsetType:OffsetType = OffsetType()*/) {
        self.fillStyle = fillStyle
        self.lineStyle = lineStyle
    }
    override func beginFill(){
        if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {
            GraphicModifier.applyProperties(getGraphic().graphics, fillStyle!/*, lineStyle*/)//apply style
        }
    }
    override func stylizeFill(){
        GraphicModifier.stylize(getGraphic().path,getGraphic().graphics)//realize style on the graphic
    }
    func setPosition(position:CGPoint){
        CGPathModifier.translate(&path,position.x,position.y)//Transformations
    }
    func setProperties(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil){// :TODO: remove this and replace with setLineStyle and setFillStyle ?
        self.fillStyle = fillStyle;
        self.lineStyle = lineStyle;
    }
    override func getGraphic()->BaseGraphic{
        return self
    }
}

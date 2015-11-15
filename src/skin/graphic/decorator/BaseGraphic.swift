import Cocoa

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
        GraphicModifier.applyProperties(getGraphic().graphics, fillStyle!/*, lineStyle*/)//apply style, FillStyle(NSColor.purpleColor()
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

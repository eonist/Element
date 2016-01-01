import Cocoa
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeable {
    var size:CGSize
    init(_ position:CGPoint, _ size:CGSize, _ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {//TODO:add the last arg through an extension?
        self.size = size
        super.init(position,decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getSize() -> CGSize {
        return size
    }
    func setSizeValue(size: CGSize) {/*<- was named setSize, but objc doesnt allow it*/
        self.size = size
    }
}
extension SizeableGraphic{
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle, _ gradientLineStyle:GradientLineStyle?, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and stroke*/
        Swift.print("Init with gradientFill")
        self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ fillStyle:IFillStyle, _ lineStyle:ILineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){
        Swift.print("Init with Fill")
        self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(fillStyle,lineStyle,lineOffset))
    }
    convenience init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat,_ height:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(fillStyle,lineStyle))
    }
    convenience init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ width:CGFloat, _ height:CGFloat, _ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(fillStyle,lineStyle))
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100,_ decoratable: IGraphicDecoratable){
        self.init(CGPoint(0,0),CGSize(width,height),decoratable)
    }
    
    convenience init(_ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100){
        self.init(CGPoint(0,0),CGSize(width,height))//BaseGraphic(FillStyle(NSColor.redColor())
    }
    convenience init(_ rect:NSRect, _ decoratable: IGraphicDecoratable){
        self.init(rect.origin,rect.size,decoratable)
    }
    
}


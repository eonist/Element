import Cocoa

class EllipseGraphic:SizeableGraphic{
    var radius:CGFloat
    //TODO: possibly add a diameter var
    //TODO: should have x and y, for the simpler line bellow use extension
    
    init(_ x:CGFloat, _ y:CGFloat, _ radius:CGFloat ,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))/*<--this shoul d be provided through an extension not here*/) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(CGPoint(x,y),CGSize(radius*2,radius*2),decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        Swift.print("CircleGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.ellipse(CGRect(0,0,width,height))
    }
    override func drawLine() {
        Swift.print("CircleGraphic.drawLine()")
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect
        Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
        graphic.lineShape.path = CGPathParser.ellipse(lineOffsetRect.lineRect)
        Swift.print("lineOffsetRect.lineRect: " + "\(lineOffsetRect.lineRect)")
    }
    override func getSize() -> CGSize {
        return CGSize(radius*2,radius*2)
    }
}
extension CircleGraphic{
    //does not work anymore, works or?
    convenience init(_ radius:CGFloat,_ fillColor:NSColor){
        self.init(0,0,radius,BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ radius:CGFloat,_ fillColor:NSColor){
        self.init(x,y,radius,BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))){
        self.init(0,0,radius,decoratable)
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ radius:CGFloat,_ fillStyle:IFillStyle){
        self.init(x,y,radius,BaseGraphic(fillStyle))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ radius:CGFloat,_ fillStyle:IFillStyle, _ lineStyle:ILineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){
        self.init(x,y,radius,BaseGraphic(fillStyle,lineStyle,lineOffset))
    }
}
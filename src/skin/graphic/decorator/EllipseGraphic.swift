import Cocoa

//TODO: fix this class
/**
 * NOTE: Dont create a circle class, ellipse will do the same as a circle
 */

class EllipseGraphic:SizeableGraphic{
    //TODO: possibly add a diameter var
    //TODO: should have x and y, for the simpler line bellow use extension
    
    /*
    init(_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))/*<--this shoul d be provided through an extension not here, maybe not*/) {
        Swift.print("EllipseGraphic.init()")
        super.init(decoratable)
    }
    */
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        Swift.print("EllipseGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.ellipse(CGRect(0,0,width,height))
    }
    override func drawLine() {
        Swift.print("EllipseGraphic.drawLine()")
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect
        Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
        graphic.lineShape.path = CGPathParser.ellipse(lineOffsetRect.lineRect)
        Swift.print("lineOffsetRect.lineRect: " + "\(lineOffsetRect.lineRect)")
    }
}
extension EllipseGraphic{
    //does not work anymore, works or?
    /*
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
    */
}
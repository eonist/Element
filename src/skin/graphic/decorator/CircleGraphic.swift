import Cocoa

class CircleGraphic:SizeableGraphic{
    var radius:CGFloat
    //TODO: possibly add a diameter var
    //TODO: should have x and y, for the simpler line bellow use extension
    
    init(_ x:CGFloat, _ y:CGFloat, _ radius:CGFloat ,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(CGPoint(x,y),CGSize(radius*2,radius*2),decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        Swift.print("CircleGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.circ(radius, 0, 0)
    }
    override func drawLine() {
        Swift.print("CircleGraphic.drawLine()")
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect

        graphic.lineShape.path = CGPathParser.ellipse(lineOffsetRect.lineRect)
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
        self.init(0,0,radius,BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))){
        self.init(0,0,radius,decoratable)
    }
}
import Cocoa

class CircleGraphic:SizeableGraphic{
    var radius:CGFloat

    //TODO: should have x and y, for the simpler line bellow use extension
    
    init(_ radius:CGFloat = 50,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(CGPoint(0,0),CGSize(radius,radius),decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        Swift.print("CircleGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        getGraphic().fillShape.path = CGPathParser.circle(radius, x, y)
    }
    override func drawLine() {
        Swift.print("CircleGraphic.drawLine()")
        graphic.lineShape.path = CGPathParser.circle(radius, x, y)
    }
    override func getSize() -> CGSize {
        return CGSize(radius,radius)
    }
}
extension CircleGraphic{
    //does not work anymore, works or?
    
    convenience init(_ radius:CGFloat,_ fillColor:NSColor){
        self.init(radius,BaseGraphic(FillStyle(fillColor)))
    }
    
}
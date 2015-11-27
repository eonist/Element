import Foundation

class CircleGraphic:BaseGraphic {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType? = nil) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(fillStyle, lineStyle, lineOffsetType)
    }
    override func initialize(){
        if(fillStyle != nil){fill()}
        if(lineStyle != nil){line()}
    }
    override func fill(){
        beginFill()
        drawFill()
        stylizeFill()
    }
    override func line(){
        //Swift.print("GraphicDecoratable.line()")
        applyLineStyle()
        drawLine()
        stylizeLine()
    }
    override func drawFill() {
        Swift.print("drawFill()")
        getGraphic().path = CGPathParser.circle(radius!, 0, 0)
    }
    override func drawLine() {
        Swift.print("drawLine()")
        graphic.linePath = CGPathParser.circle(radius!, 0, 0)
    }
}

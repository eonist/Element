import Foundation

class CircleGraphic:BaseGraphic {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType? = nil) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(fillStyle, lineStyle, lineOffsetType)
    }
    override func drawFill() {
        Swift.print("drawFill()")
        getGraphic().path = CGPathParser.circle(radius!, x, y)
    }
    override func drawLine() {
        Swift.print("drawLine()")
        graphic.linePath = CGPathParser.circle(radius!, x, y)
    }
}

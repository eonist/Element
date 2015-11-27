import Foundation

class CircleGraphic:BaseGraphic {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType? = nil) {
        self.radius = radius
        super.init(fillStyle, lineStyle, lineOffsetType)
    }

    override func drawFill() {
        CGPathParser.circle(radius!, 0, 0)
    }
    override func drawLine() {
        //needs code
        
    }
}

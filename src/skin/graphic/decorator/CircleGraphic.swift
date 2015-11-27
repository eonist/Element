import Foundation

class CircleGraphic:BaseGraphic {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType? = nil) {
        self.radius = radius
        super.init(decoratable)
    }

    override func drawFill() {
        //CGPathParser.circle(100, x, x)
    }
    override func drawLine() {
        //needs code
        
    }
}

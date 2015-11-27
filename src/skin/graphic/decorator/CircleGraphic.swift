import Foundation

class CircleGraphic:GraphicDecoratable {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(decoratable)
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

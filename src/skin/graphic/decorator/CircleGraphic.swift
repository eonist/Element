import Foundation

class CircleGraphic:GraphicDecoratable {
    var radius:CGFloat?
    init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(decoratable)
    }
    override func drawFill() {
        Swift.print("CircleGraphic.drawFill()")
        getGraphic().path = CGPathParser.circle(radius!, getGraphic().x, getGraphic().y)
    }
    override func drawLine() {
        Swift.print("CircleGraphic.drawLine()")
        graphic.linePath = CGPathParser.circle(radius!, getGraphic().x, getGraphic().y)
    }
}

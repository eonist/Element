import Foundation

class PolyLineGraphic:SizeableDecorator{
    var points:Array<CGPoint>
    init(_ points:Array<CGPoint>, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.points = points
        super.init(decoratable)
    }
    /**
     *
     */
    override func drawLine() {
        //Swift.print("PolyLineGraphic.drawLine()")
        graphic.lineShape.path = CGPathParser.lines(points, false, CGPoint(0,0))
    }
}

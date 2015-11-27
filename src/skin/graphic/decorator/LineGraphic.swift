import Foundation
/**
 * TODO: you should also probably create a class named PathGraphic
 */
class LineGraphic:GraphicDecoratable {
    var p1:CGPoint;
    var p2:CGPoint;
    init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.p1 = p1
        self.p2 = p2
        super.init(decoratable)
    }
    /**
     *
     */
    override func drawLine() {
        Swift.print("LineGraphic.drawLine()")
        graphic.linePath = CGPathParser.line(p1, p2)
    }
    /**
     *
     */
    func setPoints(p1:CGPoint, p2:CGPoint) {
        self.p1 = p1;
        self.p2 = p2;
    }
}

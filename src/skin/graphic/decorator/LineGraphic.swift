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
        //Swift.print("LineGraphic.drawLine()")
        graphic.linePath = CGPathParser.line(p1, p2)
    }
    /**
     *
     */
    func setPoints(p1:CGPoint, p2:CGPoint) {
        self.p1 = p1;
        self.p2 = p2;
    }
    /**
     * Untested
     */
    override func getSize()->CGSize{
        let relativeDifference = PointParser.relativeDifference(getPosition(), CGPoint(max(p1.x,p2.x),max(p1.y,p2.y)))
        return CGSize(relativeDifference.x,relativeDifference.y)
        //min x and y
        //max x and y
        //fatalError("Not implemented yet")
    }
    /**
     * Returns the boundingBox topLeft corner
     * Untested
     */
    override func getPosition() -> CGPoint {
        //min x and y
        return CGPoint(min(p1.x,p2.x),min(p1.y,p2.y))//topLeft
        //fatalError("Not implemented yet")
    }
}
/**
* NOTE: sets p1 to the position
* NOTE: sets p2 to the relative position of p1 to p2
*/
/*
override func setPosition(position:CGPoint){
p2.x = position.x + NumberParser.relativeDifference(p1.x, p2.x)
p2.y = position.y + NumberParser.relativeDifference(p1.y, p2.y)
p1.x = position.x
p1.y = position.y
}
*/
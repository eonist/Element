import Foundation
class LineGraphic:SizeableDecorator {
    var p1:CGPoint;
    var p2:CGPoint;
    init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.p1 = p1
        self.p2 = p2
        super.init(decoratable)
    }
    override func drawLine() {
        let pos:CGPoint = getPosition()
        let size:CGSize = getSize()
        let rect:CGRect = CGRect(pos,size)
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(rect, graphic.lineStyle!.thickness, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect
        let a:CGPoint = lineOffsetRect.lineRect.topLeft + p1-pos//<--p1,p2 is now in 0,0 coordinate space. Since the frame should only cover the actual path. We also offset the points to support the lineoffset
        let b:CGPoint = lineOffsetRect.lineRect.topLeft + p2-pos
        graphic.lineShape.path = CGPathParser.line(a, b)
    }
    override func drawFill() {
        /*must be overriden, there is no fill when using the LineGraphic*/
    }
    /**
     * 
     */
    func setPoints(p1:CGPoint, _ p2:CGPoint) {
        self.p1 = p1
        self.p2 = p2
        draw()//<--new
    }
    /**
     * Untested
     */
    override func getSize()->CGSize{
        let relativeDifference = PointParser.relativeDifference(getPosition(), CGPoint(max(p1.x,p2.x),max(p1.y,p2.y)))
        return CGSize(relativeDifference.x,relativeDifference.y)
    }
    /**
     * Returns the boundingBox topLeft corner
     * Untested
     */
    override func getPosition() -> CGPoint {
        return CGPoint(min(p1.x,p2.x),min(p1.y,p2.y))//topLeft
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension LineGraphic{
    convenience init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ lineStyle:ILineStyle) {
        self.init(p1,p2, BaseGraphic(nil,lineStyle))
    }
    convenience init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ gradientlineStyle:GradientLineStyle) {
        self.init(p1,p2, GradientGraphic(BaseGraphic(nil,gradientlineStyle)))
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
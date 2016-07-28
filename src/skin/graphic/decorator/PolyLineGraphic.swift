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
        //Swift.print("LineGraphic.drawLine()")
        let pos:CGPoint = getPosition()
        let size:CGSize = getSize()
        let rect:CGRect = CGRect(pos,size)
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(rect, graphic.lineStyle!.thickness, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect
        //Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
        //Swift.print("lineOffsetRect.lineRect: " + "\(lineOffsetRect.lineRect)")
        let a:CGPoint = lineOffsetRect.lineRect.topLeft + p1-pos//<--p1,p2 is now in 0,0 coordinate space. Since the frame should only cover the actual path. We also offset the points to support the lineoffset
        let b:CGPoint = lineOffsetRect.lineRect.topLeft + p2-pos
        graphic.lineShape.path = CGPathParser.line(a, b)
    }
}

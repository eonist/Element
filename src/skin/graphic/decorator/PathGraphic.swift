import Foundation

class PathGraphic:SizeableDecorator{
    var path:IPath
    init(_ path:IPath, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.path = path
        
        super.init(decoratable)
    }
    override func drawFill() {
        
    }
    override func drawLine() {
        let boundingBox:CGRect = CGPathGetPathBoundingBox(graphic.fillShape.path)/*there is also CGPathGetPathBoundingBox, CGPathGetBoundingBox, which works a bit different, the difference is probably just support for cruves etc*/
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(boundingBox, graphic.lineStyle!.thickness, graphic.lineOffsetType)
        graphic.lineShape.frame = boundingBox
        let offset = CGPoint(-boundingBox.x,-boundingBox.y)
        var offsetPath = graphic.fillShape.path.copy()
        graphic.fillShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)
        
        /*line*/
        let strokeBoundingBox:CGRect = SVGStyleUtils.boundingBox(fillShape.path, style!)// + boundingBox.origin
        //Swift.print("strokeBoundingBox: " + "\(strokeBoundingBox)")
        let linePathOffset:CGPoint = PointParser.difference(strokeBoundingBox.origin,CGPoint(0,0))
        //Swift.print("linePathOffset: " + "\(linePathOffset)")
        lineShape.frame = (strokeBoundingBox + boundingBox.origin).copy()
        lineShape.path = fillShape.path.copy()
        var lineOffsetPath = fillShape.path.copy()
        lineShape.path = CGPathModifier.translate(&lineOffsetPath, linePathOffset.x, linePathOffset.y)
        
    }
}

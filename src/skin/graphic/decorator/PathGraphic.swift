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
        /*fill*/
let lineOffsetRect = RectGraphicUtils.lineOffsetRect(rect, graphic.lineStyle!.thickness, graphic.lineOffsetType)
            graphic.lineShape.frame = boundingBox
            let offset = CGPoint(-boundingBox.x,-boundingBox.y)
            var offsetPath = graphic.fillShape.path.copy()
            graphic.fillShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)
        }
    }
}

import Foundation

class PathGraphic:SizeableDecorator{
    var path:IPath
    init(_ path:IPath, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.path = path
        super.init(decoratable)
    }
    override func drawFill() {
        let cgPath = DisplayPathUtils.compile(CGPathCreateMutable(), path)
        let boundingBox:CGRect = CGPathGetPathBoundingBox(cgPath)/*there is also CGPathGetPathBoundingBox, CGPathGetBoundingBox, which works a bit different, the difference is probably just support for cruves etc*/
        graphic.fillShape.frame = boundingBox
        let offset = CGPoint(-boundingBox.x,-boundingBox.y)
        var offsetPath = cgPath.copy()
        graphic.fillShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)
    }
    override func drawLine() {
        let boundingBox:CGRect = PathParser.boundingBox(graphic.fillShape.path, graphic.lineStyle!)/*regardless if the line is inside outside or centered, this will still work, as the path is already exapnded correctly*/
        graphic.lineShape.frame = boundingBox
        let offset = CGPoint(-boundingBox.x,-boundingBox.y)
        var offsetPath = graphic.fillShape.path.copy()
        graphic.lineShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)
    }
}
extension PathGraphic{
    convenience init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ lineStyle:ILineStyle) {
        self.init(p1,p2, BaseGraphic(nil,lineStyle))
    }
    convenience init(_ p1:CGPoint = CGPoint(), _ p2:CGPoint = CGPoint(), _ gradientlineStyle:GradientLineStyle) {
        self.init(p1,p2, GradientGraphic(BaseGraphic(nil,gradientlineStyle)))
    }
}
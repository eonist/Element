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
        let cgPath = DisplayPathUtils.compile(CGPathCreateMutable(), path)
        let boundingBox:CGRect = PathParser.boundingBox(cgPath, graphic.lineStyle!)/*regardless if the line is inside outside or centered, this will still work, as the path is already exapnded correctly*/
        graphic.lineShape.frame = boundingBox
        let offset = CGPoint(-boundingBox.x,-boundingBox.y)
        var offsetPath = cgPath.copy()
        graphic.fillShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)
        
    }
}
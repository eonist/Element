import Foundation

class PolyLineGraphic:PathGraphic{
    var points:Array<CGPoint>
    init(_ points:Array<CGPoint>, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.points = points
        super.init(<#T##path: IPath##IPath#>)
    }
    /**
     *
     */
    override func drawLine() {
        
        
        //continue here: Use similar boundingBox code as PathGraphic, actually you could just extend PathGraphic and override init and convert points to a Path
        
        
        //Swift.print("PolyLineGraphic.drawLine()")
        graphic.lineShape.path = CGPathParser.lines(points, false, CGPoint(0,0))
    }
}

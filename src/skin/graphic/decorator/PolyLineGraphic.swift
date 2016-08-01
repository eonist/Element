import Foundation

class PolyLineGraphic:PathGraphic{
    var points:Array<CGPoint>
    init(_ points:Array<CGPoint>, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.points = points
        let path:IPath = BasicPathParser.path(points)/*convert points to a Path*/
        super.init(path, decoratable)
    }
    //----------------------------------
    //  implicit getters / setters
    //----------------------------------
    func setPoints(points:Array<CGPoint>) {
        self.points = points
        draw()
    }
}
extension PolyLineGraphic{
    convenience init(_ points:Array<CGPoint>, _ fillStyle:IFillStyle?, _ lineStyle:ILineStyle?) {
        Swift.print("PolyLineGraphic.init() type: BaseGraphic")
        self.init(points, BaseGraphic(fillStyle,lineStyle))
    }
    convenience init(_ points:Array<CGPoint>, _ gradientFillStyle:IGradientFillStyle?, _ gradientlineStyle:IGradientLineStyle?) {
        Swift.print("PolyLineGraphic.init() type: GradientGraphic")
        self.init(points, GradientGraphic(BaseGraphic(gradientFillStyle,gradientlineStyle)))
    }
}
private class BasicPathParser{
    /**
     * // :TODO: rename to pathByPoints?
     */
    class func path(points:Array<CGPoint>) -> IPath {
        var commands:Array<Int> = [PathCommand.MOVE_TO]
        var pathData:Array<CGFloat> = [points[0].x,points[0].y]
        for (var i : Int = 1; i < points.count; i++) {
            commands.append(PathCommand.LINE_TO)
            let p:CGPoint = points[i]
            pathData += [p.x,p.y]
        }
        return Path(commands, pathData)
    }
}
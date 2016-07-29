import Foundation

class PolyLineGraphic:PathGraphic{
    var points:Array<CGPoint>
    init(_ points:Array<CGPoint>, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        self.points = points
        let path:IPath = PathParser.path(points)/*convert points to a Path*/
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
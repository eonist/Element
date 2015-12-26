import Cocoa

class GradientLineStyle:LineStyle,IGradientLineStyle {
    var gradient:IGradient
    init(_ gradient:IGradient,_ thickness:CGFloat = 1,_ color:NSColor = NSColor.blackColor(), _ lineCap:CGLineCap = CGLineCap.Butt, _ lineJoin:CGLineJoin =  CGLineJoin.Miter, _ miterLimit:CGFloat = 10) {
        self.gradient = gradient
        super.init(thickness, color, lineCap, lineJoin, miterLimit)
    }
}
/*Convenient extensions*/
extension GradientLineStyle{
    convenience init(_ gradient:IGradient,_ lineStyle:ILineStyle) {
        self.init(gradient,lineStyle.thickness,lineStyle.color,lineStyle.lineCap,lineStyle.lineJoin, lineStyle.miterLimit);
    }
}
extension IGradientLineStyle{
    func copy() -> GradientLineStyle {
        return GradientLineStyle(gradient.copy(),thickness,color,lineCap,lineJoin,miterLimit)
    }
}
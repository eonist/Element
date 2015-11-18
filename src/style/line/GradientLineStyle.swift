import Cocoa

class GradientLineStyle:LineStyle {
    var gradient:IGradient
    init(_ gradient:IGradient,_ thickness:CGFloat = 1,_ color:NSColor = NSColor.blackColor(), _ lineCap:CGLineCap = CGLineCap.Butt, _ lineJoin:CGLineJoin =  CGLineJoin.Miter, _ miterLimit:CGFloat = 10) {
        self.gradient = gradient
        super.init(thickness, color, lineCap, lineJoin, miterLimit)
    }
}
/*Convenient extensions*/
extension GradientLineStyle{
    convenience init(gradient:IGradient,lineStyle:ILineStyle) {
        self.init(gradient,lineStyle.thickness,lineStyle.color,lineStyle.lineCap,lineStyle.lineJoin, lineStyle.miterLimit);
    }
}
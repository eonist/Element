import Cocoa

class GradientLineStyle:LineStyle {
    private var gradient:IGradient
    init(gradient:IGradient,thickness:CGFloat = 1,_ color:NSColor = NSColor.blackColor(), _ lineCap:CGLineCap = CGLineCap.Butt, _ lineJoin:CGLineJoin =  CGLineJoin.Miter, _ miterLimit:CGFloat = 10) {
        self.gradient = gradient
        super.init(thickness, color, lineCap, lineJoin, miterLimit)
    }
}
extension GradientLineStyle{
    func gradientLineStyle(gradient:IGradient,lineStyle:ILineStyle)->GradientLineStyle {
        return new GradientLineStyle(gradient,lineStyle.thickness,lineStyle.color,lineStyle.alpha,lineStyle.pixelHinting, lineStyle.lineScaleMode,lineStyle.capStyle,lineStyle.jointStyle, lineStyle.miterLimit);
    }
}
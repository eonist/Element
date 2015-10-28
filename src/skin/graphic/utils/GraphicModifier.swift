import Cocoa

class GraphicModifier {
    /**
    *
    */
    class func applyProperties(path:NSBezierPath,fillStyle:IFill,lineStyle:IStroke) -> NSBezierPath {
        path
        decoratable.graphic.fillStyle = fillStyle;
        decoratable.graphic.lineStyle = lineStyle;
        nsFillColor.setFill();
        nsLineColor.setStroke();
        
        path.fill()
        path.stroke()
        return path;
    }
}
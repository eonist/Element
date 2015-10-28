import Cocoa

class GraphicModifier {
    /**
    *
    */
    class func applyProperties(path:NSPath,fillStyle:IFillStyle,lineStyle:ILineStyle) -> NSPath {
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
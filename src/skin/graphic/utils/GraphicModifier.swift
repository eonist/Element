import Cocoa

class GraphicModifier {
    /**
    *
    */
    class func applyProperties(path:NSBezierPath,fillStyle:IFill,lineStyle:IStroke) -> NSBezierPath {
       
        nsFillColor.setFill();
        nsLineColor.setStroke();
        
        
        return path;
    }
}
import Cocoa

class GraphicModifier {
    /**
    *
    */
    class func applyProperties(path:NSBezierPath,_ fillStyle:IFill,_ lineStyle:IStroke, skinState:String) -> NSBezierPath {
       
        
        let fillColor:String = style.getStyleProperty(skinState + "fillcolor")!.value as! String
        let fillAlpha:Double = style.getStyleProperty(skinState + "fillalpha")!.value as! Double
        let lineColor:String = style.getStyleProperty(skinState + "linecolor")!.value as! String
        let lineAlpha:Double = style.getStyleProperty(skinState + "linealpha")!.value as! Double
        let lineWidth:Int = style.getStyleProperty(skinState + "linewidth")!.value as! Int
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        
        nsFillColor.setFill();
        nsLineColor.setStroke();
        
        
        return path;
    }
}
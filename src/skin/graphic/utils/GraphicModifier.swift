import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(path:NSBezierPath,_ fillStyle:IStyle,_ lineStyle:IStyle, _ skinState:String) -> NSBezierPath {
       
        
        let fillColor:String = fillStyle.getStyleProperty(skinState + "fillcolor")!.value as! String
        let fillAlpha:Double = fillStyle.getStyleProperty(skinState + "fillalpha")!.value as! Double
        let lineColor:String = lineStyle.getStyleProperty(skinState + "linecolor")!.value as! String
        let lineAlpha:Double = lineStyle.getStyleProperty(skinState + "linealpha")!.value as! Double
        //let lineWidth:Int = lineStyle.getStyleProperty(skinState + "linewidth")!.value as! Int
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        
        nsFillColor.setFill();
        nsLineColor.setStroke();
        
        
        return path;
    }
    
}
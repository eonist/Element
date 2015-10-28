import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(path:NSBezierPath,_ fillStyle:IStyle,_ lineStyle:IStyle, _ skinState:String) -> NSBezierPath {
       
        
        let fillColor:String = fillStyle.getStyleProperty("fillColor")!.value as! String
        let fillAlpha:Double = fillStyle.getStyleProperty("fillAlpha")!.value as! Double
        let lineColor:String = lineStyle.getStyleProperty("lineColor")!.value as! String
        let lineAlpha:Double = lineStyle.getStyleProperty("lineAlpha")!.value as! Double
        let lineWidth:Int = lineStyle.getStyleProperty("lineWidth")!.value as! Int
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        path.lineWidth = CGFloat(lineWidth)
        
        nsFillColor.setFill();
        nsLineColor.setStroke();
        
        
        return path;
    }
    /**
    * New - it finalizes the style to the path, before it was all budnled together in the size method, now its move here
    */
    class func stylize(path:NSBezierPath){
        path.fill()
        path.stroke()
    }
}
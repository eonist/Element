import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(aPath:NSBezierPath,_ fillStyle:IStyle,_ lineStyle:IStyle, _ skinState:String) -> NSBezierPath {
        let fillColor:String = fillStyle.getStyleProperty("fillColor")!.value as! String
        let fillAlpha:Double = fillStyle.getStyleProperty("fillAlpha")!.value as! Double
        let lineColor:String = lineStyle.getStyleProperty("lineColor")!.value as! String
        let lineAlpha:Double = lineStyle.getStyleProperty("lineAlpha")!.value as! Double
        let lineWidth:Int = lineStyle.getStyleProperty("lineWidth")!.value as! Int
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        //path.lineWidth = CGFloat(lineWidth)
        
        //nsFillColor.setFill();
        //nsLineColor.setStroke();
        
        
        let graphics:Graphics = Graphics()
        var path:CGPath = CGPathParser.rect(200,200)//Shapes
        CGPathModifier.translate(&path,20,20)//Transformations
        graphics.line(12)//Stylize the line
        graphics.fill(NSColor.blueColor())//Stylize the fill
        graphics.draw(path)//draw everything
        
        
        return aPath;
        
        
        
    }
    /**
    * New - it finalizes the style to the path, before it was all budnled together in the size method, now its move here
    */
    class func stylize(path:NSBezierPath){
        //path.fill()
        //path.stroke()
    }
}
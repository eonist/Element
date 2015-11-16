import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(graphics:Graphics,_ fillStyle:IFillStyle /*,_ lineStyle:ILineStyle*//*, _ skinState:String*/){
        //Swift.print("GraphicModifier.applyProperties() " + String(fillStyle.getStyleProperty("fillColor")!.value))
        //let fillColor:String = fillStyle.getStyleProperty("fillColor")!.value as! String
        //let fillAlpha:Double = Double(String(fillStyle.getStyleProperty("fillAlpha")!.value))!
        /*
        let lineColor:String = lineStyle.getStyleProperty("lineColor")!.value as! String
        let lineAlpha:Double = lineStyle.getStyleProperty("lineAlpha")!.value as! Double
        let lineWidth:Int = lineStyle.getStyleProperty("lineWidth")!.value as! Int
        */
        
        //let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        //Swift.print(nsFillColor)
        //let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        //path.lineWidth = CGFloat(lineWidth)
        
        //nsFillColor.setFill();
        //nsLineColor.setStroke();
        ////graphics.line(CGFloat(lineWidth),nsLineColor)//Stylize the line
        

        graphics.fill(fillStyle.color)//Stylize the fill
    }
    /**
     * New - it finalizes the style to the path, before it was all budnled together in the size method, now its move here
     */
    class func stylize(path:CGPath, _ graphics:Graphics){
        //path.fill()
        //path.stroke()
        graphics.draw(path)//draw everything
    }
}
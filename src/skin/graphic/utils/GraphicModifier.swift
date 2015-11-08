import Cocoa

class GraphicModifier {
    /**
    * TODO: fill and linestyle should be graphic spessific see original code
    */
    class func applyProperties(path:CGPath, _ graphics:Graphics,_ fillStyle:IStyle,_ lineStyle:IStyle, _ skinState:String) -> CGPath {
        Swift.print(fillStyle.getStyleProperty("fillColor")!.value)
        let fillColor:String = fillStyle.getStyleProperty("fillColor")!.value as! String
        let fillAlpha:Double = fillStyle.getStyleProperty("fillAlpha")!.value as! Double
        /*
        
        
        */
        //let fillGradientType:String = fillStyle.getStyleProperty("fillGradientType")!.value as! String
        
        /*
        let fillGradientColorA:String = fillStyle.getStyleProperty("fillGradientColorA")!.value as! String
        let fillGradientColorB:String = fillStyle.getStyleProperty("fillGradientColorB")!.value as! String
        
        let lineColor:String = lineStyle.getStyleProperty("lineColor")!.value as! String
        let lineAlpha:Double = lineStyle.getStyleProperty("lineAlpha")!.value as! Double
        let lineWidth:Int = lineStyle.getStyleProperty("lineWidth")!.value as! Int
        */
        
        
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))//fill
        //let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))//line
        //ViewModifier.applyColor(self as! NSView, nsFillColor, nsLineColor, lineWidth)
        
        //path.lineWidth = CGFloat(lineWidth)
        
        //nsFillColor.setFill();
        //nsLineColor.setStroke();
        
        /*
        let nsFillGradientColorA = ColorParser.nsColor(fillGradientColorA, Float(1))
        let nsFillGradientColorB = ColorParser.nsColor(fillGradientColorB, Float(1))
        graphics.line(CGFloat(lineWidth),nsLineColor)//Stylize the line

        
        let gradient:Gradient = Gradient([nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor])
        graphics.gradientFill(gradient)
        */
        graphics.fill(nsFillColor)//Stylize the fill
        return path;
        
        
        
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
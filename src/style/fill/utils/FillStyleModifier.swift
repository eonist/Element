import Foundation

class FillStyleModifier {
    /**
     * Applies @param gradient on to @param graphics
     */
    class func beginGradientFill(graphics:Graphics,_ gradient:Gradient/*IGradient*/) {
        
        
        //continue here: figure out why the bellow nsColor works and the color in gradient doesnt. and change the types to IGradient again
        
       
        let nsFillGradientColorA = ColorParser.nsColor("FF0000"/*fillGradientColorA*/, Float(1))
        let nsFillGradientColorB = ColorParser.nsColor("0000FF"/*fillGradientColorB*/, Float(1))
        let gradient:Gradient = Gradient([nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor])
         /**/
        graphics.gradientFill(gradient)
    }
}



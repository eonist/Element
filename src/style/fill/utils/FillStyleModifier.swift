import Foundation

class FillStyleModifier {
    /**
     * Applies @param gradient on to @param graphics
     */
    class func beginGradientFill(graphics:Graphics,_ gradient:Gradient/*IGradient*/) {
        
        
        //continue here: figure out why the bellow nsColor works and the color in gradient doesnt. and change the types to IGradient again
        
       
        let nsFillGradientColorA = ColorParser.nsColor("FF0000"/*fillGradientColorA*/, Float(1))
        let nsFillGradientColorB = ColorParser.nsColor("0000FF"/*fillGradientColorB*/, Float(1))
        /*
        Swift.print("___")
        Swift.print(gradient.locations[0])
        Swift.print(gradient.locations[1])
        Swift.print("___")
        */
        //Swift.print(gradient.locations.count)
        let gradient:Gradient = Gradient([gradient.colors[0]/*nsFillGradientColorA.CGColor*/,gradient.colors[1]/*nsFillGradientColorB.CGColor*/])
         /**/
        graphics.gradientFill(gradient)
    }
}



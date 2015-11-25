import Foundation

class FillStyleModifier {
    /**
     * Applies @param gradient on to @param graphics
     */
    class func beginGradientFill(graphics:Graphics,_ gradient:IGradient) {
        /*
        let nsFillGradientColorA = ColorParser.nsColor("FF0000"/*fillGradientColorA*/, Float(1))
        let nsFillGradientColorB = ColorParser.nsColor("0000FF"/*fillGradientColorB*/, Float(1))
        let gradient:Gradient = Gradient([nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor])
        */
        graphics.gradientFill(gradient)
    }
}



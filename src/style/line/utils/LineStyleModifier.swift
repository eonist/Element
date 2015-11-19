import Foundation

class LineStyleModifier {
    /**
    *
    */
    class func lineGradientStyle(graphics:Graphics,_ gradient:IGradient) {
        let nsFillGradientColorA = ColorParser.nsColor("FF00FF"/*fillGradientColorA*/, Float(1))
        let nsFillGradientColorB = ColorParser.nsColor("00FF00"/*fillGradientColorB*/, Float(1))
        let gradient:Gradient = Gradient([nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor])
        graphics.gradientLine(gradient)
        //graphics.lineGradientStyle(gradient.type, gradient.colors, gradient.alphas, gradient.ratios, gradient.matrix, gradient.spreadMethod, gradient.interpolationMethod, gradient.focalPointRatio);
    }
}

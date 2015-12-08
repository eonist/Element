import Cocoa

class LineStyleModifier {
    /**
    *
    */
    class func lineGradientStyle(graphics:Graphics,_ gradient:IGradient) {
        let nsFillGradientColorA:NSColor = NSColorParser.nsColor("FF00FF"/*fillGradientColorA*/, 1.0)
        let nsFillGradientColorB:NSColor = NSColorParser.nsColor("00FF00"/*fillGradientColorB*/, 1.0)
        let gradient:Gradient = Gradient([nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor])
        graphics.gradientLine(gradient)
        //graphics.lineGradientStyle(gradient.type, gradient.colors, gradient.alphas, gradient.ratios, gradient.matrix, gradient.spreadMethod, gradient.interpolationMethod, gradient.focalPointRatio);
    }
}

import Cocoa

class LineStyleModifier {
    /**
    *
    */
    class func lineGradientStyle(graphics:Graphics,_ gradient:IGradient) {
        let nsFillGradientColorA:NSColor = NSColor.magentaColor()
        let nsFillGradientColorB:NSColor = NSColor.cyanColor()
        let gradient:Gradient = Gradient(gradient.colors)//[nsFillGradientColorA.CGColor,nsFillGradientColorB.CGColor]
        graphics.gradientLine(gradient)
        //graphics.lineGradientStyle(gradient.type, gradient.colors, gradient.alphas, gradient.ratios, gradient.matrix, gradient.spreadMethod, gradient.interpolationMethod, gradient.focalPointRatio);
    }
}

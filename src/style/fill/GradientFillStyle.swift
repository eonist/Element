import Cocoa

class GradientFillStyle:FillStyle,IGradientFillStyle{
    var gradient:IGradient/*IGradient*///TODO:change to IGradient
    init(_ gradient:IGradient/*IGradient*/, _ color:NSColor = NSColor.clearColor()){
        self.gradient = gradient
        super.init(color)
    }
}
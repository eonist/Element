import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:IGradient;
    init(_ gradient:Gradient/*IGradient*/, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }
}

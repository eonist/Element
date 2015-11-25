import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:Gradient/*IGradient*/;
    init(_ gradient:Gradient/*IGradient*/, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }
}

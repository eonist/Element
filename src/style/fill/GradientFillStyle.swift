import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:IGradient;
    init(_ gradient:IGradient, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }
}

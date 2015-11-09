import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:IGradient;
    init(_ gradient:IGradient, _ color:NSColor){
        super.init(color);
        self.gradient = gradient;
    }
}

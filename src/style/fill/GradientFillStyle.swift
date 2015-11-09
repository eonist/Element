import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:IGradient;
    init(gradient:IGradient, color:NSColor){
        super.init(color);
        self.gradient = gradient;
    }
}

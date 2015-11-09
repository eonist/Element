import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:IGradient;
    init(gradient:IGradient = nil, color:NSColor){
        super.init(color,alpha);
        _gradient = gradient;
    }
}

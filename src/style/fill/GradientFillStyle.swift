import Cocoa

protocol IGradientFillStyle{
    
}
class GradientFillStyle:FillStyle{
    var gradient:Gradient/*IGradient*/;//TODO:change to IGradient
    init(_ gradient:Gradient/*IGradient*/, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }

    
}

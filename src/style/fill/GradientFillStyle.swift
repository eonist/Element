import Cocoa

class GradientFillStyle:FillStyle{
    var gradient:Gradient/*IGradient*/;//TODO:change to IGradient
    init(_ gradient:Gradient/*IGradient*/, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }
    override func copy() -> Copyable {
        return FillStyle(self)
    }
}
extension GradientFillStyle{
    convenience init(_ gradientFillStyle:GradientFillStyle){
        self.init(gradientFillStyle.gradient,gradientFillStyle.color)
    }
    
    
}
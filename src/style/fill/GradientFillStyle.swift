import Cocoa

protocol IGradientFillStyle{
    
}
class GradientFillStyle:FillStyle{
    var gradient:Gradient/*IGradient*/;//TODO:change to IGradient
    init(_ gradient:Gradient/*IGradient*/, _ color:NSColor){
        self.gradient = gradient;
        super.init(color);
    }

    required init(_ instance: Copyable) {
        fatalError("init has not been implemented")
    }
    
}
extension IGradientFillStyle:Copyable{
    
    /*
    convenience init(_ gradientFillStyle:GradientFillStyle){
    self.init(gradientFillStyle.gradient,gradientFillStyle.color)
    }
    func copy() -> Copyable {
    return FillStyle(self)
    }
    */
    
}
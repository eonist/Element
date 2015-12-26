import Foundation
protocol IGradientFillStyle{
    var gradient:Gradient{get set}
}
extension IGradientFillStyle{
    func copy() -> GradientFillStyle {
        return GradientFillStyle(self.gradient,(self as! IFillStyle).color)
    }
}
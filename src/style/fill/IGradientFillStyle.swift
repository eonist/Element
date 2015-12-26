import Foundation
protocol IGradientFillStyle{
    var gradient:Gradient{get set}
}
extension IGradientFillStyle{
    func copy() -> IGradientFillStyle {
        return GradientFillStyle(self.gradient,(self as! IFillStyle).color)
    }
}
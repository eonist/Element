import Foundation
protocol IGradientFillStyle{
    var gradient:IGradient{get set}
}
extension IGradientFillStyle{
    func copy() -> GradientFillStyle {
        return GradientFillStyle(self.gradient.copy(),(self as! IFillStyle).color)
    }
}
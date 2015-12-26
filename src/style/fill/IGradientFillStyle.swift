import Foundation
protocol IGradientFillStyle:IFillStyle{
    var gradient:IGradient{get set}
}
extension IGradientFillStyle{
    func copy() -> IGradientFillStyle {
        return GradientFillStyle(self.gradient.copy(),(self as IFillStyle).color)
    }
}
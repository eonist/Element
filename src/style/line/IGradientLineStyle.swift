import Foundation

protocol IGradientLineStyle:ILineStyle {
    var gradient:IGradient{get set}
}
extension IGradientLineStyle{
    func mix(colors:Array<CGColor>)->GradientLineStyle{
        let c = copy()
        c.gradient.colors = colors
        return c
    }
}
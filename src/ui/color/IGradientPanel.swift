import Foundation

protocol IGradientPanel {//this should probably extend IColorInput
    func setGradient(gradient:IGradient)
    var gradient:IGradient {get}
}

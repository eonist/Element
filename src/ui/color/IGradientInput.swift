import Foundation

protocol IGradientPanel {//this should probably extend IColorInput
    var gradient:IGradient? {get}
    func setGradient(gradient:IGradient)
}
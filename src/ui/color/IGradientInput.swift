import Foundation

protocol IGradientInput {//this should probably extend IColorInput
    var gradient:IGradient? {get}
    func setGradient(gradient:IGradient)
}
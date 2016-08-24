import Foundation

protocol IGradientInput:IEventSender {//this should probably extend IColorInput
    var gradient:IGradient? {get}
    func setGradient(gradient:IGradient)
}
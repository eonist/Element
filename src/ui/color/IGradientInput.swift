import Foundation

protocol IGradientInput:IEventSender {/*This should probably extend IColorInput*/
    var gradient:IGradient? {get}
    func setGradient(gradient:IGradient)
}
import Foundation
@testable import Utils

protocol IGradientInput:IEventSender {/*This should probably extend IColorInput*/
    var gradient:IGradient? {get}
    func setGradient(_ gradient:IGradient)
}

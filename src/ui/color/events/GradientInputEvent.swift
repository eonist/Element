import Foundation
@testable import Utils

class GradientInputEvent:Event{
    enum GradientInputEventType: String {case Change = "gradientInputChange"}
    init(_ type:GradientInputEventType = .Change, _ origin:AnyObject){
        super.init(type.rawValue, origin)
    }
}
extension GradientInputEvent{
    var gradient:IGradient? {return (origin as! IGradientInput).gradient}
}

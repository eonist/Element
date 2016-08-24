import Foundation

class GradientInputEvent:Event{
    enum GradientInputEventType: String {case change = "gradientInputChange"}
    override init(_ type:String = "", _ origin:AnyObject){
        super.init(type, origin)
    }
}
extension GradientInputEvent{
    var gradient:IGradient? {return (origin as! IGradientInput).gradient}
}
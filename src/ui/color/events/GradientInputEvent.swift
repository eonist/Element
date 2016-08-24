import Foundation

class GradientInputEvent:Event{
    static var change:String = "gradientInputChange"//probably should be ColorInputChange
    override init(_ type:String = "", _ origin:AnyObject){
        super.init(type, origin)
    }
}
extension GradientInputEvent{
    var gradient:IGradient? {return (origin as! IGradientInput).gradient}
}
import Foundation

class NodeSliderEvent :Event{
    static var change:String = "nodeSliderEventChange"
    var startProgress:CGFloat
    var endProgress:CGFloat
    init(_ type: String, _ startProgress:CGFloat,_ endProgress:CGFloat, _ origin:AnyObject) {
        self.startProgress = startProgress
        self.endProgress = endProgress
        super.init(type, origin)
    }
}
extension NodeSliderEvent{
    var selected:ISelectable {return (origin as! INodeSlider).selected!}
}
import Foundation
@testable import Utils

class NodeSliderEvent:Event{
    static var change:String = "nodeSliderEventChange"
}
extension NodeSliderEvent{
    var selected:ISelectable {return (origin as! INodeSlider).selectGroup!.selected!}
    var startProgress:CGFloat {return (origin as! INodeSlider).startProgress}
    var endProgress:CGFloat {return (origin as! INodeSlider).endProgress}
}

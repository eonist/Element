import Foundation
/**
 * HorizontalNodeSlider is used when 2 sliders are need, as in section definition or zoom, or gradient values
 * // :TODO: to get the toFront method working you need to support relative positioning, currently the Element framework doesnt support this
 * // :TODO: support for custom node shape design
 * // :TODO: when implimenting selectgroup functionality you need to be able to change set the selection on press not on release (You might need to impliment NodeButton that impliments iselectable in order to make this happen)
 */
class VNodeSlider {
    var startNode:SelectButton?
    var endNode:SelectButton?
    var selectGroup:SelectGroup?
    var nodeHeight:CGFloat
    var tempNodeMouseY:CGFloat
    var startProgress:CGFloat
    var endProgress:CGFloat
    init(_width:CGFloat = NaN, height:CGFloat = NaN, nodeHeight:CGFloat = NaN, startProgress:CGFloat = 0,endProgress:CGFloat = 1, parent:IElement = nil, id:String = nil, classId:String = nil) {
        self.startProgress = startProgress
        self.endProgress = endProgress
        self.nodeHeight = nodeHeight.isNaN ? width:nodeHeight
        super.init(width, height, parent, id)
    }
}
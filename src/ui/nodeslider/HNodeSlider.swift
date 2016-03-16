import Foundation
/**
 * HorizontalNodeSlider is used when 2 sliders are need, as in section definition or zoom, or gradient values
 */
class HNodeSlider:Element {
    var startNode:SelectButton
    var endNode:SelectButton
    var selectGroup:SelectGroup
    var nodeWidth:Number
    var tempNodeMouseX:Number
    var startProgress:Number
    var endProgress:Number
    init(width:CGFloat = NaN, height:CGFloat = NaN, nodeWidth:CGFloat = NaN, startProgress:CGFloat = 0, endProgress:CGFloat = 1, parent:IElement? = nil, id:String? = nil, classId:String? = nil) {
        _startProgress = startProgress;
        _endProgress = endProgress;
        _nodeWidth = isNaN(nodeWidth) ? height:nodeWidth;
        super(width, height, parent, id,classId);
        addEventListeners();
    }
}

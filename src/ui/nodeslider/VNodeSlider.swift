import Foundation
/**
 * HorizontalNodeSlider is used when 2 sliders are need, as in section definition or zoom, or gradient values
 * // :TODO: to get the toFront method working you need to support relative positioning, currently the Element framework doesnt support this
 * // :TODO: support for custom node shape design
 * // :TODO: when implimenting selectgroup functionality you need to be able to change set the selection on press not on release (You might need to impliment NodeButton that impliments iselectable in order to make this happen)
 */
class VNodeSlider {
    private var _startNode : SelectButton;
    private var _endNode : SelectButton;
    private var _selectGroup : SelectGroup;
    private var _nodeHeight : Number;
    private var _tempNodeMouseY : Number;
    private var _startProgress : Number;
    private var _endProgress : Number;
}

import Foundation
/**
 * HSlider is a simple horizontal slider
 * @Note the reason we have two sliders instead of 1 is because otherwise the math and variable naming scheme becomes too complex (same goes for the idea of extending a Slider class)
 * // :TODO: consider having thumbWidth and thumbHeight, its just easier to understand
 */
class HSlider {
    var progress : CGFloat;
    var thumbWidth : CGFloat;
    var thumb : Button;
    var tempThumbMouseX:CGFloat;/*This value holds the onDown position when you click the thumb*/
    init(width:CGFloat, _ height:CGFloat, _ thumbWidth:CGFloat, progress:CGFloat = 0, parent:IElement? = nil, id:String? = nil, classId:String? = nil) {
        self.progress = progress
        self.thumbWidth = thumbWidth.isNaN ? height:thumbWidth
        super.init(width, height, parent, id, classId)
        addEventListeners()
    }
}

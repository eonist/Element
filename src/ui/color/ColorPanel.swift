import Cocoa
/**
 * // :TODO: add an alpha-stepper?
 */
class ColorPanel {
    static var title:String = "Color"
    static var minSize:CGPoint = CGPoint(180, 232)
    static var maxSize:CGPoint = CGPoint(1200,232)
    static var RGB:String = "RGB"
    static var HSB:String = "HSB"
    static var HLS:String = "HLS"
    static var HSV:String = "HSV"
    static var color:NSColor
    static var colorInput:ColorInput?
    static var spinner1:LeverSpinner?
    static var spinner2:LeverSpinner?
    static var spinner3:LeverSpinner?
    static var itemHeight:CGFloat
    static var colorTypeSelectGroup:SelectGroup?
}
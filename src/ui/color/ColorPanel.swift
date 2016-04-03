import Foundation
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
    private var _color : Number;
    private var _colorInput : ColorInput;
    private var _spinner1 : LeverSpinner;
    private var _spinner2 : LeverSpinner;
    private var _spinner3 : LeverSpinner;
    private var _itemHeight:Number;
    private var _colorTypeSelectGroup:SelectGroup;
}

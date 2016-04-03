import Cocoa
/**
 * // :TODO: add an alpha-stepper?
 */
class ColorPanel:Element{
    static var title:String = "Color"
    static var minSize:CGPoint = CGPoint(180, 232)
    static var maxSize:CGPoint = CGPoint(1200,232)
    static var RGB:String = "RGB"
    static var HSB:String = "HSB"
    static var HLS:String = "HLS"
    static var HSV:String = "HSV"
    var color:NSColor
    var colorInput:ColorInput?
    var spinner1:LeverSpinner?
    var spinner2:LeverSpinner?
    var spinner3:LeverSpinner?
    var itemHeight:CGFloat
    var colorTypeSelectGroup:SelectGroup?
    init(width:CGFloat = NaN, height:CGFloat = NaN, itemHeight:CGFloat = NaN, color:NSColor = NSColorParser.nsColor("0xFF00FF"), title:String = "Color", minSize:CGPoint? = nil, maxSize:CGPoint? = nil, parent:IElement? = nil, id:String = "") {
        self.itemHeight = itemHeight
        self.color = color
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        var rgbBtn = addSubView(RadioButton(NaN,NaN,RGB,true,self))
        var hsbBtn = addSubView(RadioButton(NaN,NaN,HSB,false,self))
        var hlsBtn = addSubView(RadioButton(NaN,NaN,HLS,false,self))
        var hsvBtn = addSubView(RadioButton(NaN,NaN,HSV,false,self))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
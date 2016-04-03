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
        var rgbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.RGB,true,self))
        var hsbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HSB,false,self))
        var hlsBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HLS,false,self))
        var hsvBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HSV,false,self))
        
        _colorTypeSelectGroup = addChild(new SelectGroup([rgbRadioButton,hsbRadioButton,hlsRadioButton,hsvRadioButton],rgbRadioButton)) as SelectGroup;
        _colorInput = addChild(new ColorInput(width,_itemHeight,"Color:",_color,this)) as ColorInput;
        var rgbObj:Object = ColorParser.rgbByHex(_color);/*LeaverStepper instance ->Red (0 - 255) (Read/write)*/
        _spinner1 = addChild(new LeverSpinner(width, _itemHeight,"Red:",rgbObj["rb"],1,0,255,1,100,200,this)) as LeverSpinner;
        _spinner2 = addChild(new LeverSpinner(width, _itemHeight,"Green:",rgbObj["gb"],1,0,255,1,200,200,this)) as LeverSpinner;/*LeaverStepper instance ->Green (0 - 255) (Read/write)*/
        _spinner3 = addChild(new LeverSpinner(width, _itemHeight,"Blue:",rgbObj["bb"],1,0,255,1,200,200,this)) as LeverSpinner;/*LeaverStepper instance ->Blue (0 - 255) (Read/write)*/
        ColorSync.broadcaster = this;
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
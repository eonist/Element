import Cocoa
/**
 * // :TODO: add an alpha-stepper?
 */
class ColorPanel:Element,IColorPanel{
    static var title:String = "Color"
    static var minSize:CGPoint = CGPoint(180, 232)
    static var maxSize:CGPoint = CGPoint(1200,232)
    static var rgb:String = "RGB"
    static var hsb:String = "HSB"
    static var hls:String = "HLS"
    static var hsv:String = "HSV"
    var color:NSColor
    var colorInput:ColorInput?
    var spinner1:LeverSpinner?
    var spinner2:LeverSpinner?
    var spinner3:LeverSpinner?
    var itemHeight:CGFloat
    var colorTypeSelectGroup:SelectGroup?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ color:NSColor = NSColor.redColor(), _ title:String = "Color", _ parent:IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight
        self.color = color
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        /*Radio buttons*/
        let rgbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.rgb,true,self))
        let hsbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hsb,false,self))
        let hlsBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hls,false,self))
        let hsvBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hsv,false,self))
        /*SelectGroup*/
        colorTypeSelectGroup = SelectGroup([rgbBtn,hsbBtn,hlsBtn,hsvBtn],rgbBtn)
        colorTypeSelectGroup!.event = onEvent/*attach the selectGroup to self, to handle the events here*/
        colorInput = addSubView(ColorInput(width,itemHeight,"Color:",color,self))
        let rgb:RGB = color.rgb/*LeverStepper instance ->Red (0 - 255) (Read/write)*/
        /*LeverSpinner*/
        spinner1 = addSubView(LeverSpinner(width, itemHeight,"Red:",rgb.r.cgFloat,1,0,255,1,100,200,self))
        spinner2 = addSubView(LeverSpinner(width, itemHeight,"Green:",rgb.g.cgFloat,1,0,255,1,200,200,self))/*LeaverStepper instance ->Green (0 - 255) (Read/write)*/
        spinner3 = addSubView(LeverSpinner(width, itemHeight,"Blue:",rgb.b.cgFloat,1,0,255,1,200,200,self))/*LeaverStepper instance ->Blue (0 - 255) (Read/write)*/
        ColorSync.broadcaster = self
    }
    private func onColorTypeSelectGroupChange(event:SelectGroupEvent) {
        //Swift.print("onColorTypeSelectGroupChange()")
        ColorPanelUtils.toggleColorType(self,(event.selectable as! TextButton).getText())
        ColorPanelUtils.applyColor(self,color)
    }
    private func onColorInputChange(event : ColorInputEvent) {
        Swift.print("ColorPanel.onColorInputChange()")
        ColorPanelUtils.applyColor(self,event.color)
        color = event.color
        super.onEvent(event)// :TODO: is thhis needed? cant we just propegate the original event
    }
    private func onSpinnerChange(event:SpinnerEvent) {
        //Swift.print("onSpinnerChange()")
        var color:NSColor//<--was UInt
        let colorType:String = (SelectGroupParser.selected(colorTypeSelectGroup!) as! TextButton).getText()// :TODO: just call getColorType
        //Swift.print("colorType: " + "\(colorType)")
        switch(colorType){
            case ColorPanel.rgb:color = RGB(spinner1!.val.uint, spinner2!.val.uint, spinner3!.val.uint).nsColor;break;
            case ColorPanel.hsb:color = HSB(spinner1!.val/360, (spinner2!.val/100), (spinner3!.val/100)).nsColor;break;
            case ColorPanel.hls:color = HLS(spinner1!.val, spinner2!.val, spinner3!.val).nsColor;break;
            case ColorPanel.hsv:color = HSV(spinner1!.val, spinner2!.val/240, spinner3!.val/240).nsColor;break;
            default:fatalError("this can't happen"); break;
        }
        /*
        Swift.print("spinner1!.val: " + "\(spinner1!.val)")
        Swift.print("spinner2!.val: " + "\(spinner2!.val)")
        Swift.print("spinner3!.val: " + "\(spinner3!.val)")
        Swift.print("color: " + "\(color.hexString)")
        */
        colorInput!.setColorValue(color)
        self.color = color
        super.onEvent(ColorInputEvent(ColorInputEvent.change,self))
    }
    override func onEvent(event: Event) {
        super.onEvent(event)
        if(event.type == SelectGroupEvent.change && event.origin === colorTypeSelectGroup){onColorTypeSelectGroupChange(event as! SelectGroupEvent)}
        if(event.type == ColorInputEvent.change && event.origin === colorInput){onColorInputChange(event as! ColorInputEvent)}
        if(event.type == SpinnerEvent.change){onSpinnerChange(event as! SpinnerEvent)}// :TODO: cant we just listen for one event in this.?
        //if(event.type == ColorInputEvent.change){ColorSync.onColorChange(event as! ColorInputEvent)}
    }
    func setColorValue(color:NSColor){
        ColorPanelUtils.applyColor(self,color)
        colorInput!.setColorValue(color)
        self.color = color
    }
    override func setSize(width : CGFloat, _ height : CGFloat)  {
        super.setSize(width, height)
        ElementModifier.refresh(self)
    }
    func getColorType()->String {
        return (SelectGroupParser.selected(colorTypeSelectGroup!) as! RadioButton).getText()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
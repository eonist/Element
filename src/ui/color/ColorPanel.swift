import Cocoa
/**
 * // :TODO: add an alpha-stepper?
 */
class ColorPanel:Element,IColorPanel{
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
        let rgbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.RGB,true,self))
        let hsbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HSB,false,self))
        let hlsBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HLS,false,self))
        let hsvBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.HSV,false,self))
        colorTypeSelectGroup = SelectGroup([rgbBtn,hsbBtn,hlsBtn,hsvBtn],rgbBtn)
        colorInput = addSubView(ColorInput(width,itemHeight,"Color:",color,self))
        //var rgbObj:Object = ColorParser.rgbByHex(color)/*LeaverStepper instance ->Red (0 - 255) (Read/write)*/
        
        let rb:CGFloat = 255
        let gb:CGFloat = 0
        let bb:CGFloat = 0
        
        spinner1 = addSubView(LeverSpinner(width, itemHeight,"Red:",rb,1,0,255,1,100,200,self))
        spinner2 = addSubView(LeverSpinner(width, itemHeight,"Green:",gb,1,0,255,1,200,200,self))/*LeaverStepper instance ->Green (0 - 255) (Read/write)*/
        spinner3 = addSubView(LeverSpinner(width, itemHeight,"Blue:",bb,1,0,255,1,200,200,self))/*LeaverStepper instance ->Blue (0 - 255) (Read/write)*/
        ColorSync.broadcaster = self
    }
    override func onEvent(event: Event) {
        super.onEvent(event)
        //if(event.type == SelectGroupEvent.change && event.origin === colorTypeSelectGroup){onColorTypeSelectGroupChange(event)}
        //if(event.type == ColorInputEvent.change && event.origin === colorInput){onColorInputChange(event)}
        if()
        /*
        _spinner1.addEventListener(SpinnerEvent.CHANGE, onSpinnerChange);// :TODO: cant we just listen for one event in this.?
        _spinner2.addEventListener(SpinnerEvent.CHANGE, onSpinnerChange);
        _spinner3.addEventListener(SpinnerEvent.CHANGE, onSpinnerChange);
        addEventListener(ColorInputEvent.CHANGE, ColorSync.onColorChange);
        */
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
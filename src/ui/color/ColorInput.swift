import Cocoa
@testable import Utils
/**
 * TODO: this could just extend TextInput right?
 * TODO: the input could be sans "0x" ?
 * NOTE: even though creating an eventhandler in the parent class for when to open the ColorWin is tedious, including it in this class is not a good idea, consider when ColorInput is only used as an indicatar of color and not as opener for ColorWin
 */
class ColorInput:Element,IColorInput {
    var colorBox:ColorBox?
    var inputText:TextInput?
    var text:String
    var color:NSColor?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ text:String = "Color: ", _ color:NSColor = NSColor.red,_ parent:IElement? = nil,_ id:String = ""){
        self.text = text
        self.color = color
        super.init(width,height,parent,id)
    }
    override func resolveSkin(){
        super.resolveSkin()
        self.inputText = addSubView(TextInput(width - height,height,text,"0x" + color!.hexString,self))//ColorParser.hexByNumericRgb(_color)
        self.colorBox = addSubView(ColorBox(height,height,color!,self))
    }
    func onColorBoxDown(_ event:ButtonEvent){
        ColorSync.receiver = self/*Can't we set this outside this class?, nopp probably shouldn't*/
        super.onEvent(ColorInputEvent(ColorInputEvent.colorBoxDown,self))
    }
    /**
     * NOTE: asserts if the color is a valid color before it is applied
     */
    func onTextInputChange(_ event:TextFieldEvent){
        //Swift.print("onTextInputChange() ")
        let colorString:String = inputText!.inputTextArea!.text!.getText()//could also use: event.stringValue here
        if(ColorAsserter.isColor(colorString)){
            color = NSColorParser.nsColor(colorString.uint)
            colorBox!.setColorValue(color!)
            super.onEvent(ColorInputEvent(ColorInputEvent.change,self))//sends the event
        }
    }
    override func onEvent(_ event:Event) {
        if(event.type == ButtonEvent.down && event.origin === colorBox){onColorBoxDown(event as! ButtonEvent)}
        if(event.type == TextFieldEvent.update && event.immediate === inputText){onTextInputChange(event as! TextFieldEvent)}
    }
    func setColorValue(_ color:NSColor){
        self.color = color
        colorBox!.setColorValue(color)
        inputText!.inputTextArea!.setTextValue("0x" + color.hexString.uppercased())//ColorParser.hexByNumericRgb(color).toUpperCase()
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat){
        super.setSize(width,height)
        inputText!.setSize(width,inputText!.height)
        /*<--should probably just refresh the state here*/
        colorBox!.skin!.setSkinState(colorBox!.skin!.state)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

import Cocoa
/**
 * // :TODO: this could just extend TextInput right?
 * // :TODO: the input could be sans "0x" ?
 * @Note even though creating an eventhandler in the parent class for when to open the ColorWin is tedious, including it in this class is not a good idea, consider when ColorInput is only used as an indicatar of color and not as opener for ColorWin
 */
class ColorInput:Element,IColorInput {
    var colorBox:ColorBox?
    var inputText:TextInput?
    var text:String
    var color:NSColor
    init(width:CGFloat = NaN, height:CGFloat = NaN, text:String = "Color: ", color:NSColor = NSColor.magentaColor(), parent:IElement? = nil, id:String = ""){
        self.text = text
        self.color = color
        super.init(width,height,parent,id)
    }
    override func resolveSkin(){
        super.resolveSkin();
        self.inputText = addSubView(TextInput(width - height,height,text,"0x" + color.hex,self))//ColorParser.hexByNumericRgb(_color)
        self.colorBox = addSubView(ColorBox(height,height,color,self)) as ColorBox;
    }
    func onColorBoxDown(event:ButtonEvent){
        //ColorSync.receiver = self
        /*cant we set this outside this class?*/
        super.onEvent(ColorInputEvent(ColorInputEvent.colorBoxDown,self))
    }
    /**
     * @Note asserts if the color is a valid color before it is applied
     */
    func onTextInputChange(event:TextFieldEvent){
        Swift.print("onTextInputChange() ")
        let colorString:String = inputText!.inputTextArea!.text!.getText()//could also use: event.stringValue here
        if(ColorAsserter.isColor(colorString)){
            color = NSColorParser.nsColor(colorString.uint)
            colorBox!.setColorValue(color);
            super.onEvent(ColorInputEvent(ColorInputEvent.change,color))//sends the event
        }
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.down && event.origin === colorBox){onColorBoxDown(event as! ButtonEvent)}
        if(event.type == TextFieldEvent.update && event.immediate === inputText){onTextInputChange(event as! TextFieldEvent)}
    }
    func setColorValue(color:NSColor){
        self.color = color
        colorBox!.setColorValue(color)
        inputText!.inputTextArea!.setTextValue("0x" + color.hex.uppercaseString)//ColorParser.hexByNumericRgb(color).toUpperCase()
    }
    func setSize(width:CGFloat, height:CGFloat){
        super.setSize(width,height)
        inputText!.setSize(width,inputText!.height)
        /*<--should probably just refresh the state here*/
        colorBox!.skin!.setSkinState(colorBox!.skin!.state)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

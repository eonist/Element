import Cocoa
/**
 * TODO: For the sake of optiomization, TextSkin should not extend Skin, but rather extend NSText. Less views means better speed
 */
class TextSkin:Skin,ITextSkin{
    var textField:NSText;
    //the bellow variable is a little more complex in the original code
    override var width:CGFloat? {get{return textField.frame.width} set{textField.frame.width = newValue!}}// :TODO: make a similar funciton for getHeight, based on needed space for the height of the textfield
    private var hasTextChanged:Bool = true;/*<-Why is is this true by default?*/
    //func setText(text:String)
    init(_ style:IStyle, _ text:String, _ state:String = SkinStates.none, _ element:IElement? = nil){
        //Swift.print("TextSkin.init()")
        textField = NSText(frame: NSRect(x: 0, y: 0, width: 200, height: 200))//set w and h to 0
        //textField.sizeToFit()
        textField.string = text;
        super.init(style, state, element)
        addSubview(textField)
        applyProperties(textField);
        SkinModifier.float(self)
        SkinModifier.align(self, textField)
        textField.hidden = SkinParser.display(self) == CSSConstants.none
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func draw() {
        //do aligning here
        applyProperties(textField);
        super.draw()
    }
    func applyProperties(textField:NSText){
        
        //Continue here, bug here cant get width
        
        let width:CGFloat = StylePropertyParser.width(self) ?? super.width!
        //Swift.print("width: " + "\(width)")
        let height:CGFloat = StylePropertyParser.height(self) ?? super.height!
        //Swift.print("height: " + "\(height)")
        textField.frame.width = width
        textField.frame.height = height
        super.frame.width = width//quick fix
        super.frame.height = height//quick fix
        let textFormat:TextFormat = StylePropertyParser.textFormat(self)
        //Swift.print("TextSkin.applyProperties() textFormat.color: " + String(textFormat.color))
        TextFieldModifier.applyTextFormat(textField,textFormat);
    }
    /**
     * Set the text and updates the skin
     * // :TODO: add more advance setText features like start and end etc
     */
    func applyText(text:String){
        textField.string = text;
        hasTextChanged = true;
        draw();
    }
}
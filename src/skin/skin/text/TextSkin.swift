import Cocoa

class TextSkin:Skin,ITextSkin{
    var textField:NSText;
    //the bellow variable is a little more complex in the original code
    override var width:CGFloat? {get{return textField.frame.width} set{textField.frame.width = newValue!}}// :TODO: make a similar funciton for getHeight, based on needed space for the height of the textfield
    private var hasTextChanged:Bool = true;/*<-Why is is this true by default?*/
    //func setText(text:String)
    init(_ style:IStyle, _ text:String, _ state:String = SkinStates.none, _ element:IElement? = nil){
        Swift.print("TextSkin.init()")
        textField = NSText(frame: NSRect(x: 0, y: 0, width: 100, height: 100))//set w and h to 0
        addSubview(textField)
        textField.string = text;
        super.init(style, state, element)
        applyProperties(textField);
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func draw() {
        //do aligning here
        super.draw()
    }
    func applyProperties(textField:NSText){
        
        //Continue here, bug here cant get width
        
        let width:CGFloat = StylePropertyParser.width(self) ?? super.width!
        let height:CGFloat = StylePropertyParser.height(self) ?? super.height!
        textField.frame.width = width
        textField.frame.height = height
        let textFormat:TextFormat = StylePropertyParser.textFormat(self)
        TextFieldFormatModifier.applyTextFormat(textField,textFormat);
    }
    /**
     * Set the text and updates the skin
     * // :TODO: add more advance setText features like start and end etc
     */
    func setText(text:String){
        textField.string = text;
        hasTextChanged = true;
        draw();
    }
}
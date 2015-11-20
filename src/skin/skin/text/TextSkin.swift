import Cocoa

class TextSkin:Skin,ITextSkin{
    var textField:NSText;
    //func setText(text:String)
    init(style:IStyle, text:String, state:String = SkinStates.none, element:IElement? = nil){
        textField = NSText(frame: NSRect(x: 0, y: 0, width: 100, height: 100))//set w and h to 0
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
        let width:CGFloat = StylePropertyParser.width(self)!
        let height:CGFloat = StylePropertyParser.height(self)!
        textField.frame.width = width
        textField.frame.height = height
    }
}
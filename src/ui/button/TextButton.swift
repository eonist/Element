import Cocoa

class TextButton:Button {
    var text:Text? = nil;
    var textString:String;
    init(_ text:String = "defaultText", _ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        textString = text;
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func resolveSkin() {
        super.resolveSkin();
        text = Text(width,height,textString/*,self*/)
        addSubview(text!)
        text?.isInteractive = false;
    }
    override func applySkinState(skinState:String) {
        super.applySkinState(skinState);
        text!.skin!.applySkinState(skinState);
    }
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
    }
    /**
     * Returns the text in the _text.textField.text
     */
    func getText()->String{
        return text.getText();
    }
    /**
    * Sets the text in the _text instance
    */
    func applyText(text:String){
        //text.applyText(text);
    }
}

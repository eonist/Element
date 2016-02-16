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
        text = addSubView(Text(width,height,textString,self)) as? Text
        text?.isInteractive = false
    }
    override func setSkinState(skinState:String) {
        super.setSkinState(skinState);
        text!.skin!.setSkinState(skinState);/*why is this set directly to the skin and not to the element?*/
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height);
        text!.setSize(width, height);
    }
    /**
     * Returns the text in the _text.textField.text
     */
    func getText()->String{
        return text!.getText();
    }
    /**
     * Sets the text in the _text instance
     * NOTE: cant be named setText as its blocked by objc
     */
    func setTextValue(text:String){
        self.text!.setText(text);
    }
}

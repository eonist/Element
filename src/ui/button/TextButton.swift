import Cocoa

class TextButton:Button {
    var text:Text? = nil;
    var textString:String;
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "defaultText", _ parent: IElement?, _ id: String?) {
        textString = text;
        super.init(width, height, parent, id)
    }
    convenience init(_ text:String = "defaultText", _ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        self.init(width,height,text,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        text = addSubView(Text(width,height,textString,self))
        text?.isInteractive = false
    }
    override func setSkinState(skinState:String) {
        //Swift.print("\(self.dynamicType)" + " setSkinState() skinState: " + "\(skinState)")
        super.setSkinState(skinState);
        text!.setSkinState(skinState);/*why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
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
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

import Cocoa
@testable import Utils
class TextButton:Button {
    var text:Text? = nil
    var textString:String
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ parent:IElement?, _ id:String? = nil) {
        textString = text;
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        text = addSubView(Text(width,height,textString,self))
        text?.isInteractive = false
    }
    override func setSkinState(_ skinState:String) {
        //Swift.print("\(self.dynamicType)" + " setSkinState() skinState: " + "\(skinState)")
        super.setSkinState(skinState)
        text!.setSkinState(skinState)/*Why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        text!.setSize(width, height)
    }
    /**
     * Returns the text in the _text.textField.text
     */
    func getText()->String{
        return text!.getText()
    }
    /**
     * Sets the text in the _text instance
     * NOTE: cant be named setText as its blocked by objc
     */
    func setTextValue(_ text:String){
        self.text!.setText(text)
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/*
extension TextButton{
    /**
     * NOTE: Keep this method around until you have phased out this way of initiating
     */
    convenience init(_ text:String = "defaultText", _ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        self.init(width,height,text,parent,id)
    }
}
*/

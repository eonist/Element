import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ get rid of LableKind
 */
class TextButton:Button,LableKind {
    lazy var text:Text = self.createText()
    var textString:String/*Interim value*/
    init(text:String = "defaultText" ,size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        textString = text
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        Swift.print("TextButton.resolveSkin before")
        super.resolveSkin()
        Swift.print("TextButton.resolveSkin before text")
        _ = text
        Swift.print("TextButton.resolveSkin after")
    }
    override func mouseDown(_ event:MouseEvent) {
        super.mouseDown(event)
        Swift.print(ElementParser.stackString(text))
    }
    override var skinState:String {
        get {return super.skinState}
        set {
            super.skinState = newValue
            text.skinState = (newValue)/*Why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
        }
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        text.setSize(width, height)
    }
    /**
     * Returns the text in the _text.textField.text
     */
    func getText()->String{
        return text.getText()
    }
    /**
     * Sets the text in the _text instance
     * NOTE: cant be named setText as its blocked by objc
     */
    func setTextValue(_ text:String){
        self.text.setText(text)
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
    //DEPRECATED
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ parent:ElementKind?, _ id:String? = nil) {
        textString = text
        super.init(width, height, parent, id)
    }
}
extension TextButton {
    /**
     * Makes lazy var more organized
     */
    func createText()->Text{
        Swift.print("createText")
        Swift.print("self.skinSize: " + "\(self.skinSize)")
        let text = self.addSubView(Text.init(text: self.textString, size: self.skinSize, id: nil))//(text;,size:)
        text.isInteractive = false
        Swift.print("before return createText")
        return text
    }
}


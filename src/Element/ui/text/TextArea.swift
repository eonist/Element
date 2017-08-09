import Foundation
@testable import Utils
/**
 * :TODO: ⚠️️ Maybe rename text to defaultText and _text to _text
 * :TODO: Add support for setting size via css for the TextArea. Its currently not working
 */
class TextArea:Element {
    lazy var text:Text = {self.addSubView(Text(self.getWidth(),self.getHeight(),self.textString,self))}()
    private var textString:String/*Interim value*/
    init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = text
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        text.setSize(width, height)
    }
    func setTextValue(_ textStr:String) {
        Swift.print("TextArea.setTextValue")
        text.setText(textStr)
    }
    func getTextValue() -> String {
        Swift.print("getTextValue() \(text.getText())")
        return text.getText()
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

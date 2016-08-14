import Foundation
/**
 * :TODO: maybe rename text to defaultText and _text to _text
 * :TODO: Add support for setting size via css for the TextArea. Its currently not working
 */
class TextArea:Element {
    var text:Text?
    var textString:String// :TODO: rename to initTextString
    init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        text = addSubView(Text(width,height,self.textString,self)) 
    }
    func setSize(width:CGFloat, height:CGFloat) {
        super.setSize(width, height)
        text!.setSize(width, height)
    }
    func setTextValue(text:String) {
        self.text!.setText(text)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
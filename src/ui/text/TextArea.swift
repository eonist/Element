import Foundation
/**
 * :TODO: maybe rename text to defaultText and _text to _text
 */
class TextArea:Element {
    var text:Text?
    var textString:String// :TODO: rename to initTextString
    init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text;
        super.init(width, height, parent, id)
    }
    func setSize(width:CGFloat, height:CGFloat) {
        super.setSize(width, height);
        text!.setSize(width, height);
    }
    func setText(text:String) {
        text.setText(text);
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

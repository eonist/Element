import Foundation

class TextArea:Element {
    var text:Text?
    var textString:String// :TODO: rename to initTextString
    init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text;
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

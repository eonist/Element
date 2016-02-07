import Foundation

class TextInput :Element{
    var text : Text?
    var inputTextArea : TextArea?
    var textString:String
    var inputString:String
    init(width : CGFloat, height : CGFloat, textString:String, inputString:String, parent : IElement? = nil,  id:String? = nil, classId:String? = nil) {
        self.textString = textString
        self.inputString = inputString
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        isInteractive = false//<-- only the textField should be interactive
        text = addSubView(Text(width,height,self.textString,self)) as? Text
        inputTextArea = addSubView(TextArea(width,height,String(self.inputString),self)) as? TextArea;
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

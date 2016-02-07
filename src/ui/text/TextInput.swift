import Foundation

class TextInput :Element{
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
        _text = addChild(new Text(width,height,_textString,this)) as Text;
        _inputTextArea = addChild(new TextArea(width,height,String(_inputString),this)) as TextArea;
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}

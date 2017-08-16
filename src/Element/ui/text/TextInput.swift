import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Through extension you should add a way to set inputTextArea text value.
 * TODO: Rename inputTextArea to inputText
 * TODO: ⚠️️ Store ids as Enum Keys, so unfold can reuse these
 */
class TextInput:Element{
    lazy var text:Text = {return (Text(self.getWidth(),self.getHeight(),self.initData.text,self,"text"))}()
    lazy var inputTextArea:TextArea = {return (TextArea(self.getWidth(),self.getHeight(),self.initData.input,self,"inputText"))}()
    private let initData:(text:String,input:String)/*interim use only, use inputText  etc to get data*/
    init(_ width:CGFloat, _ height:CGFloat, _ textString:String, _ inputString:String, _ parent:ElementKind? = nil,  _ id:String? = nil) {
        self.initData = (textString,inputString)
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        addSubview(text)
        addSubview(inputTextArea)
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        inputTextArea.setSize(width, height)//⚠️️ shouldn't this be setSkin rather?
        text.setSize(width, height)//⚠️️ shouldn't this be setSkin rather?
    }
    override func setSkinState(_ state:String) {
        super.setSkinState(state)
        inputTextArea.setSkinState(state)
        text.setSkinState(state)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension TextInput{
    func setInputText(_ text:String){/*Convenience*/
        Swift.print("TextInput.setInputText")
        inputTextArea.setTextValue(text)
    }
    var inputText:String {return inputTextArea.text.getText()}
//    //New
//    convenience init(size:CGSize = CGSize(NaN,NaN), text:String = "", _ input:String = "", parent:ElementKind? = nil, id:String? = nil){
//        self.init(size.width, size.height, text, input,parent,id)
//    }
}

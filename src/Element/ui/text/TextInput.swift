import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Through extension you should add a way to set inputTextArea text value.
 * TODO: Rename inputTextArea to inputText
 * TODO: ⚠️️ Store ids as Enum Keys, so unfold can reuse these
 */

extension TextInput{
    struct TextInputInitial:InitDecoratable{
        var text:String = ""
        var input:String = ""
        var initial:Initiable = Initial()
    }
}

class TextInput:Element{
    lazy var text:Text = {return self.addSubView(Text(self.getWidth(),self.getHeight(),self.initData.text,self,"text"))}()
    lazy var inputTextArea:TextArea = {return self.addSubView(TextArea(self.getWidth(),self.getHeight(),self.initData.input,self,"inputText"))}()
    
//    private var textString:String/*interim use only, use inputText to get data*/
//    private var inputString:String/*interim use only, use inputText to get data*/
    var initData:TextInputInitial {return super.initial as? TextInputInitial ?? {fatalError("initial not avaiable")}()}
    init(_ width:CGFloat, _ height:CGFloat, _ textString:String, _ inputString:String, _ parent:ElementKind? = nil,  _ id:String? = nil) {
//        self.textString = textString
//        self.inputString = inputString
        let initial = Initial(size: CGSize(width, height), parent: parent, id: id)
        super.init(initial:TextInputInitial(text:textString,input:inputString,initial:initial))
    }
    override init(initial: Initiable) {
        
        super.init(initial: initial)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = text
        _ = inputTextArea
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
    //New
    convenience init(size:CGSize = CGSize(NaN,NaN), text:String = "", _ input:String = "", parent:ElementKind? = nil, id:String? = nil){
        self.init(size.width, size.height, text, input,parent,id)
    }
}

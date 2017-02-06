import Foundation
@testable import Utils

class TextInput:Element{
    var text:Text?
    var inputTextArea:TextArea?
    var textString:String
    var inputString:String
    init(_ width:CGFloat, _ height : CGFloat, _ textString:String, _ inputString:String, _ parent : IElement? = nil,  _ id:String? = nil) {
        self.textString = textString
        self.inputString = inputString
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        //isInteractive = true//<-- only the textField should be interactive
        text = addSubView(Text(width,height,textString,self))
        inputTextArea = addSubView(TextArea(width,height,inputString,self))
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
        inputTextArea!.setSize(width, height)//shouldn't this be setSkin rather?
        text!.setSize(width, height)//shouldn't this be setSkin rather?
    }
    override func setSkinState(_ state:String) {
        super.setSkinState(state)
        inputTextArea!.setSkinState(state)
        text!.setSkinState(state)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

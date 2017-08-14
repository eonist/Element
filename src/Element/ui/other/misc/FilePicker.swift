import Foundation
@testable import Utils

class FilePicker:Element{
    //size:self.initData.size,text:self.initData.text,input:self.initData.input,parent:self.initData.parent,id:self.initData.id
    lazy var textInput:TextInput = .init(initial:self.textInputInitial)
    lazy var button:TextButton = .init(initial:self.buttonInitial)
    override init(initial: Initiable) {
        super.init(initial: initial)
    }
    override func resolveSkin() {
        super.resolveSkin()
        addSubview(textInput)
        addSubview(button)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}
extension FilePicker{
    var initData:FilePickerInitial {return super.initial as? FilePickerInitial ?? {fatalError("initial not avaiable")}()}
    var textInputInitial:TextInput.TextInputInitial {return .init(text: self.initData.text, input: self.initData.input, initial: self.initData)}
    var buttonInitial:TextButton.TextButtonInitial {return .init(initial:self.initData,text:self.initData.buttonText)}
    struct FilePickerInitial:InitDecoratable {
        var text:String = "",input:String = "",buttonText:String = ""
        var initial:Initiable
    }
}

import Foundation
@testable import Utils
/**
 * When you need to browse for files or urls
 * NOTE: this is a Composition of other UI components
 * TODO: ⚠️️ Add some event logic to this class, and modal popup
 */
class FilePicker:Element{
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
    var textInputInitial:TextInput.TextInputInitial {
        let initial = Initial(size:self.initData.size,parent:self,id:nil)
        return .init(text: self.initData.text, input: self.initData.input, initial: initial)
    }
    var buttonInitial:TextButton.TextButtonInitial {
        let initial = Initial(size:self.initData.size,parent:self,id:nil)
        return .init(initial:initial,text:self.initData.buttonText)
    }
    struct FilePickerInitial:InitDecoratable {
        var text:String = "",input:String = "",buttonText:String = ""
        var initial:Initiable
    }
}

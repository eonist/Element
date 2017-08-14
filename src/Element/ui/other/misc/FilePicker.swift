import Foundation
@testable import Utils

class FilePicker:Element{
    lazy var textInput:TextInput = TextInput()
    lazy var button:Button = Button()
    init(size:CGSize = CGSize(NaN,NaN), text:String = "",input:String = "",buttonText:String = "",parent:ElementKind? = nil,id:String? = nil) {
        super.init(size: size, parent: parent, id: id)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}

import Foundation
@testable import Utils

class FilePicker:Element{
    lazy var textInput:TextInput = TextInput()
    lazy var button:Button = Button()
    override func resolveSkin() {
        super.resolveSkin()
        
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}

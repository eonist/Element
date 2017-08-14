import Foundation
@testable import Utils

class FilePicker:Element{
    init(size:CGSize, parent: IElement?, id: String?) {
        super.init(size.width, size.height, parent, id)
    }
    lazy var textString:String = ""
    lazy var inputString:String = ""
    lazy var textInput:TextInput = TextInput()
    override func resolveSkin() {
        super.resolveSkin()
        
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}

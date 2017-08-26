import Cocoa
@testable import Utils
/**
 * When you need to browse for files or urls
 * NOTE: this is a Composition of other UI components
 * TODO: ⚠️️ Add some event logic to this class, and modal popup
 * TODO: ⚠️️ Add data accessorts to this class
 */
class FilePicker:Element{
    typealias InitText = (text:String,input:String,button:String)
    lazy var textInput:TextInput = createTextInput()
    lazy var button:TextButton = createButton()
    private let text:InitText
    init(text:InitText, size:CGSize = CGSize(NaN,NaN), id:String? = nil) {
        self.text = text
        super.init(size:size, id:id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        addSubview(textInput)
        addSubview(button)
    }
    override func onEvent(_ event: Event) {
        if event.assert(.upInside) {
            onBrowseButtonClick()
        }
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}
extension FilePicker{
    func onBrowseButtonClick(){
        //Swift.print("onBrowseButtonClick")
        let dialog:NSOpenPanel = NSOpenPanel()//prompt the file viewer
        dialog.canCreateDirectories = true
        dialog.title = "Select path"
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = true
        dialog.directoryURL = {
            let dirURLStr:String = textInput.inputText
            return dirURLStr.tildePath.url
        }()
        let respons = dialog.runModal()
        if let url = dialog.url,respons == NSApplication.ModalResponse.OK{
            textInput.setInputText(url.path.tildify)
        }
    }
    func createTextInput()->TextInput{
        return .init(self.getWidth(),self.getHeight(),text.text,text.input,self,"inputText")
    }
    func createButton()->TextButton{
        return .init(self.getWidth(), self.getHeight(), text.button, self)
    }
}

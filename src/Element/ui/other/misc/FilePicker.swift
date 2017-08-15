import Cocoa
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
    override func onEvent(_ event: Event) {
        if event.assert(.upInside) {
            onBrowseButtonClick()
        }
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
    func onBrowseButtonClick(){
        //Swift.print("onBrowseButtonClick")
        let myFileDialog:NSOpenPanel = NSOpenPanel()//prompt the file viewer
        myFileDialog.canCreateDirectories = true
        myFileDialog.title = "Select path"
        myFileDialog.canChooseDirectories = true
        myFileDialog.canChooseFiles = true
        myFileDialog.runModal()
         /*Get the path to the file chosen in the NSOpenPanel*/
        if let thePath =  myFileDialog.url?.path {/*Make sure that a path was chosen*/
            textInput.setInputText(thePath.tildify)
        }
    }
}

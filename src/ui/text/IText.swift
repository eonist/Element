import Cocoa

protocol IText:IElement {
    func setText(text:String)
    var textField:NSText{get}
    var initText:String{get}
}

import Cocoa

protocol ITextSkin:ISkin {
    var textField:NSText{get};
    func setText(text:String)
}

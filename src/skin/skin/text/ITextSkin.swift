import Cocoa

protocol ITextSkin:ISkin {
    var textField:NSText{get};
    func applyText(text:String)
}

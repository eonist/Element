import Cocoa

protocol ITextSkin:ISkin {
    var textField:TextField{get};
    func applyText(text:String)
}

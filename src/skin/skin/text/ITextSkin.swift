import Cocoa

protocol ITextSkin:ISkin {
    var textField:TextField{get};
    func setText(text:String)
}

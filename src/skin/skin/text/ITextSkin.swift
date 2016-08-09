import Cocoa

protocol ITextSkin:class,ISkin {
    var textField:TextField{get}
    func setText(text:String)
}

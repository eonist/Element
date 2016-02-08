import Cocoa

protocol ITextSkin:ISkin {
    var textField:CustomText{get};
    func setText(text:String)
}

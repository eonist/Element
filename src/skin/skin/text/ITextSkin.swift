import Cocoa

protocol ITextSkin:ISkin {
    var textField:NSText{get};
    var text:String{get set}
}

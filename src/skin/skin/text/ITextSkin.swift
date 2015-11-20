import Cocoa

protocol ITextSkin:ISkin {
    var textField:NSText{get};
    text(text:String):void;
}

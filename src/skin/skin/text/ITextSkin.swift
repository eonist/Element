import Cocoa
@testable import Utils

protocol ITextSkin:class,ISkin {
    var textField:TextField{get}
    func setText(_ text:String)
}

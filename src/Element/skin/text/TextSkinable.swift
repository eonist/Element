import Cocoa
@testable import Utils

protocol ITextSkin:class,ISkin {
    var textField:NSTextField{get}
    func setText(_ text:String)
}

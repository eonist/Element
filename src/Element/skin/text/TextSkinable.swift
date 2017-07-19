import Cocoa
@testable import Utils

typealias ITextSkin = TextSkinable
protocol TextSkinable:class,Skinable {
    var textField:NSTextField{get}
    func setText(_ text:String)
}

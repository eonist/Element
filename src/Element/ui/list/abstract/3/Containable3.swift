import Cocoa
@testable import Utils
@testable import Element

protocol Containable3:class{/*We extend class because it will use NSView anyway*/
    var maskSize:CGSize {get}
    var contentSize:CGSize {get}
    var contentContainer:Element? {get}
}
extension Containable3{
    var width:CGFloat {return maskSize.width}
    var height:CGFloat {return maskSize.height}
}

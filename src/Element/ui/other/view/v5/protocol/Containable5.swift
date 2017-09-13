import Foundation


protocol Containable5:class{/*We extend class because it will use NSView anyway*/
    var maskSize:CGSize {get}
    var contentSize:CGSize {get}
    var contentContainer:Element {get}
}
extension Containable5{
    var width:CGFloat {return maskSize.width}//try to remove this
    var height:CGFloat {return maskSize.height}//try to remove this
}

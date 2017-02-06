import Cocoa
@testable import Utils

protocol IText:IElement {
    func setText(_ text:String)
    func getTextField()->TextField
    var initText:String{get}
}

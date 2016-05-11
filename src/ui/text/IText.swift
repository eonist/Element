import Cocoa

protocol IText:IElement {
    func setText(text:String)
    func getTextField()->TextField
    var initText:String{get}
}
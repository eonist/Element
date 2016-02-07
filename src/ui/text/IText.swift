import Cocoa

protocol IText:IElement {
    func setText(text:String)
    func getTextField()->NSText
    var initText:String{get}
}

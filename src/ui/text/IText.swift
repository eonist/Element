import Cocoa

protocol IText:IElement {
    func applyText(text:String)
    func getTextField()->NSText
    var initText:String{get}
}

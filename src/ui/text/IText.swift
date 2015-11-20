import Cocoa

protocol IText:IElement {
    func setTextString(text:String)
    func getTextField()->NSText
    var initText:String{get}
}

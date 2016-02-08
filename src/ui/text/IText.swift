import Cocoa

protocol IText:IElement {
    func setText(text:String)
    func getTextField()->CustomText
    var initText:String{get}
}

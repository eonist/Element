import Cocoa

protocol IText:IElement {
    var text:String{get set}
    var textField:NSText{get}
    var initText:String{get}
}

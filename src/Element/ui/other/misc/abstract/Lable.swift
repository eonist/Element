import Foundation

protocol LableKind{
    var text:Text? {get set}
    func getText()->String
    func setTextValue(_ text:String)
}

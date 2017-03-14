import Foundation

protocol StateChangeable:class {
    var state:String {get set}
    func getSkinState() -> String
    func setSkinState(_ state:String)
}

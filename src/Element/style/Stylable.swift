import Foundation

protocol Stylable {
    var name:String {get}
    var selectors:[SelectorKind] {get}
    var styleProperties:[StylePropertyKind] {get set}
}

import Foundation
typealias IStyle = Stylable
protocol Stylable {
    var name:String {get}
    var selectors:[ISelector] {get}
    var styleProperties:[IStyleProperty] {get set}
}

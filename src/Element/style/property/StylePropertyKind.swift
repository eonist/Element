import Foundation
/**
 * TODO: ⚠️️ Rename to StylePropertyKind ?
 */
typealias IStyleProperty = StylePropertyKind
protocol StylePropertyKind {
    var value:Any {get set}
    var name:String {get set}
    var depth:Int {get}
}

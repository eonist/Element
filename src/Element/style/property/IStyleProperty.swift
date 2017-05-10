import Foundation
/**
 * TODO: ⚠️️ rename to StylePropertyKind ?
 */
protocol IStyleProperty {
    var value: Any {get set}
    var name:String {get set}
    var depth:Int {get}
}

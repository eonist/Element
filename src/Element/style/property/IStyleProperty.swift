import Foundation
/**
 * TODO: ⚠️️ Rename to StylePropertyKind ?
 */
protocol IStyleProperty {
    var value:Any {get set}
    var name:String {get set}
    var depth:Int {get}
}

import Foundation
/**
 * This exist so that focusable and disableable can work
 */
protocol SkinStateChangeable:class {
    var skinState:String {get set}
//    func getSkinState() -> String
//    func setSkinState(_ state:String)
}

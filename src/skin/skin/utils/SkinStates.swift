import Foundation
/**
 * TODO: These will probably be upgraded to enums soon, since swift has awesome syntactic support for enums
 */
class SkinStates {
    /*Core*/
    static var none:String = ""/*aka: idle*/
    static var over:String = "over"
    static var down:String = "down"
    /*Other*/
    static var selected:String = "selected"
    static var checked:String = "checked"
    static var focused:String = "focused"
    static var disabled:String = "disabled"
}
/*
enum SkinStates:String
case None = ""
case Over = "over"
//etc
*/
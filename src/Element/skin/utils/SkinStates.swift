import Foundation
/**
 * TODO: ⚠️️ These will probably be upgraded to enums soon, since swift has awesome syntactic support for enums
 * TODO: ⚠️️ Or you could extens String and set receiving params to take SkinStates and then do: .over etc use class var if you need to override
 */
enum SkinStates {//rename to SkinStateTypes maybe?
    /*Core*/
    static let none:String = ""/*aka: idle*/
    static let over:String = "over"
    static let down:String = "down"
    /*Other*/
    static let selected:String = "selected"
    static let checked:String = "checked"
    static let focused:String = "focused"
    static let disabled:String = "disabled"
}
/*
enum SkinStates:String
case None = ""
case Over = "over"
//etc
*/

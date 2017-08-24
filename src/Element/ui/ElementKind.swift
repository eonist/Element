import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Move getWidth, size etc to Another protocol
 */
protocol ElementKind:ViewKind,Disableable,Focusable{/*:class <--- derive only classes for the protocol, not structs, this enables === operator of protocol, because struct can never be a ref*/
    typealias UIState = (isDisabled:Bool,isFocused:Bool)
    /*Core methods*/
    func resolveSkin()
    /*Implicit getters / setters*/
    func getParent()->Any?//TODO: maybe use weak?
    func setSize(_ width:CGFloat, _ height:CGFloat)
    //func getParent(isAbsoltuteParent:Bool = false)->Any
    func getClassType()->String
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    /*Getters / Setters*/
    var parent:ElementKind?{get}
    //var state:String{get set}/*skinState is renamed to state because objc won't allow implicit setter with the same name*/
    var skin:Skinable?{get set}
    var id:String?{get}
    var skinSize:CGSize {get}
    var x:CGFloat{get set}
    var y:CGFloat{get set}
    var uiState:UIState {get set}
}
/**
 * NOTE: some of these methods will probably be moved back into the class
 * TODO: add convenince methods for setting x and y independently?
 */
extension ElementKind {
    var x:CGFloat {get{return self.frame.x}set{self.frame.x = newValue}}
    var y:CGFloat {get{return self.frame.y}set{self.frame.y = newValue}}
    /**
     * NOTE: This isn't fully implemented, see notes on the blog, see legacy code
     * NOTE: This method will always return an NSView or nil if isAbsolute is set to true, and either NSView or NSWindow or nil if isAbosulte is set to false
     */
    func getParent()->Any? {// :TODO: beta
        return self.parent
    }
    /**
     * Positions the Element instance to PARAM: point,
     * TODO: ⚠️️ This could also be move to an utils class
     */
    func setPosition(_ point:CGPoint){
        frame.x = point.x
        frame.y = point.y
    }
    func getWidth()->CGFloat{
        return skin != nil ? skin!.getWidth() : NaN
    }
    func getHeight()->CGFloat{
        return skin != nil ? skin!.getHeight() : NaN
    }
    var isDisabled:Bool {get{return uiState.isDisabled} set{uiState.isDisabled = newValue}}
    var isFocused:Bool  {get{return uiState.isFocused} set{uiState.isFocused = newValue}}
}

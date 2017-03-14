    import Foundation
@testable import Utils
protocol IElement:IView,Disableable,Focusable{/*:class <--- derive only classes for the protocol, not structs, this enables === operator of protocol, because struct can never be a ref*/
    /*Core methods*/
    func resolveSkin()
    /*Implicit getters / setters*/
    func getSkinState() -> String
    func setSkinState(_ state:String)
    func getParent()->Any?//TODO: maybe use weak?
    func setSize(_ width:CGFloat, _ height:CGFloat)
    //func getParent(isAbsoltuteParent:Bool = false)->Any
    func getClassType()->String
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    /*Getters / Setters*/
    var parent:IElement?{get}
    //var state:String{get set}/*skinState is renamed to state because objc won't allow implicit setter with the same name*/
    var skin:ISkin?{get set}
    var id:String?{get}
    var width:CGFloat{get /*set*/}
    var height:CGFloat{get /*set*/}
    var x:CGFloat{get set}
    var y:CGFloat{get set}
}
/**
 * NOTE: some of these methods will probably be moved back into the class
 * TODO: add convenince methods for setting x and y independently?
 */
extension IElement {
    var x:CGFloat {get{return self.frame.x}set{self.frame.x = newValue}}
    var y:CGFloat {get{return self.frame.y}set{self.frame.y = newValue}}
    /*
    var width:CGFloat {return self.frame.width}
    var height:CGFloat {return self.frame.height}
    */
    /**
     * NOTE: This isn't fully implemented, see notes on the blog, see legacy code
     * NOTE: This method will always return an NSView or nil if isAbsolute is set to true, and either NSView or NSWindow or nil if isAbosulte is set to false
     */
    func getParent()->Any? {// :TODO: beta
        //Swift.print("_parent: " + _parent);
        return self.parent
    }
    /**
     * Positions the Element instance to PARAM: point,
     * TODO: this could also be move to an utils class
     */
    func setPosition(_ point:CGPoint){
        /*
        self.x = point.x;
        self.y = point.y;
        */
        frame.x = point.x
        frame.y = point.y
    }
}

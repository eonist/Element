import Foundation

protocol IElement:class,IView{/*:class <--- derive only classes for the protocol, not structs, this enables === operator of protocol*/
    /*core methods*/
    func resolveSkin()
    /*implicit getters / setters*/
    func getSkinState() -> String
    func setSkinState(skinState:String)
    func getParent()->Any?//TODO: maybe use weak?
    func setSize(width:CGFloat, _ height:CGFloat)
    //func getParent(isAbsoltuteParent:Bool = false)->Any
    func getClassType()->String
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    
    /*getters / setters*/
    var parent:IElement?{get}
    //var state:String{get set}/*skinState is renamed to state because objc wont allow implicit setter with the same name*/
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    var id : String?{get};
    //var x:CGFloat{get set}
    //var y:CGFloat{get set}
    var width:CGFloat{get set}
    var height:CGFloat{get set}
    var x:CGFloat{get set}
    var y:CGFloat{get set}
}
/**
 * NOTE: some of these methods will probably be moved back into the class
 * TODO: add convenince methods for setting x and y independently?
 */
extension IElement {
    /*var width:CGFloat {return self.frame.width}
    var height:CGFloat {return self.frame.height}*/
    /**
     * NOTE: this isnt fully implemented, see notes on the blog, see legacy code
     * NOTE: This method will always return an NSView or nil if isAbsolute is set to true, and either NSView or NSWindow or nil if isAbosulte is set to false
     */
    func getParent()->Any? {// :TODO: beta
        //Swift.print("_parent: " + _parent);
        return self.parent;
    }
    /**
     * Positions the Element instance to @param point,
     * TODO: this could also be move to an utils class
     */
    func setPosition(point:CGPoint){
        /*
        self.x = point.x;
        self.y = point.y;
        */
        frame.x = point.x
        frame.y = point.y
    }
    /**
     * TODO: this is likly to be overridden in the future, move to the Element class
     */
    func getWidth()->CGFloat{
        return skin != nil ? skin!.getWidth() : CGFloat.NaN;
    }
    /**
     * TODO: this is likly to be overridden in the future, move to the Element class
     */
    func getHeight()->CGFloat{
        return skin != nil ? skin!.getHeight() : CGFloat.NaN;
    }
}

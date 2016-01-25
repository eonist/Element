import Foundation

protocol IElement:class,IView{/*:class <--- derive only classes for the protocol, not structs, this enables === operator of protocol*/
    /*core methods*/
    func resolveSkin()
    /*implicit getters / setters*/
    func getSkinState() -> String
    func setSkinState(skinState:String)
    func getParent()->Any?//TODO: maybe use weak?
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
    var width:CGFloat{get}
    var height:CGFloat{get}
}
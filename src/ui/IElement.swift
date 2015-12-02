import Foundation

protocol IElement:class,IView{/*:class <--- derive only classes for the protocol, not structs, this enables === operator of protocol*/
    var parent:IElement?{get}
    var state:String{get set}/*skinState is renamed to state because objc wont allow implicit setter with the same name*/
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    var id : String?{get};
    //var x:CGFloat{get set}
    //var y:CGFloat{get set}
    var width:CGFloat{get}
    var height:CGFloat{get}
    func resolveSkin()
    func getSkinState() -> String
    func setSkinState(skinState:String)
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
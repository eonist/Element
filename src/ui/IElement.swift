import Foundation

protocol IElement:class,/*<-Notice this*/ IView{
    var parent:IElement?{get}
    var skinState:String{get set}
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    var id : String?{get};
    //var x:CGFloat{get set}
    //var y:CGFloat{get set}
    var width:CGFloat{get}
    var height:CGFloat{get}
    func resolveSkin()
    func getSkinState() -> String
    /*func setSkinState(skinState:String)*/
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
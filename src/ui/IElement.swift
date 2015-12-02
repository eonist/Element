import Foundation

//Continue here: maybe that :class thing will solve the problem with using protocols and casting?
//try to make a variable that is explicit and implicit in Element , like var tempName setTempName etc. 
//naming implicit setters applySkinState is not an option. As a last restor name the variable to skinStateValue

protocol IElement:class,/*<-Notice this*/ IView{
    var parent:IElement?{get}
    var skinState:String{get set}
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    var id : String?{get};
    var name:String{get set}
    func setName(name:String)
    func getName()->String

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
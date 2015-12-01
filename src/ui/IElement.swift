import Foundation
protocol IElement:class, IView{
    var parent:IElement?{get}
    var skinState:String{get}
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    var id : String?{get};
    //var x:CGFloat{get set}
    //var y:CGFloat{get set}
    var width:CGFloat{get}
    var height:CGFloat{get}
    func resolveSkin()
    func getSkinState() -> String
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
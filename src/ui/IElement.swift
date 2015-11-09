import Foundation
protocol IElement:class, IView{
    var parent:IElement?{get}
    var skinState:String{get}
    var style:IStyle{get set}
    var width:Int?{get}
    var height:Int?{get}
    func resolveSkin()
    func getSkinState() -> String
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
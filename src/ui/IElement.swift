import Foundation
protocol IElement:class, IView{
    var parent:IElement?{get}
    var skinState:String{get}
    var style:IStyle{get set}
    func resolveSkin()
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
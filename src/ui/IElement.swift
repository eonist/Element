import Foundation
protocol IElement:class, IView{
    func resolveSkin()
    var style:IStyle{get set}
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    var skinState:String{get}
}
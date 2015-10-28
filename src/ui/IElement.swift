import Foundation
protocol IElement:class, IView{
    func resolveSkin()
    var style:IStyle{get set}
    func getClassType()->String
    var skinState:String{get}
}
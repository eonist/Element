import Foundation
protocol IElement:class, IView{
    func resolveSkin()
    var style:IStyle{get}
    func setStyle(style:IStyle)
    func getClassType()->String
    var skinState:String{get}
}
import Foundation
protocol IElement:class, IView{
    var parent:IElement?{get}
    var skinState:String{get}
    var style:IStyle{get set}
    var skin:ISkin?{get set}
    /*
    var x:CGFloat{get set}
    var y:CGFloat{get set}

    
    */
    var width:Double?{get set}
    var height:Double?{get set}
    func resolveSkin()
    func getSkinState() -> String
    func getParent()->IElement?//TODO: maybe use weak?
    func getClassType()->String
    
}
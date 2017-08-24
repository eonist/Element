import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Rename to Skinable or SkinKind
 */
protocol Skinable:class{
    typealias HasChanged = (style:Bool,state:Bool,size:Bool)
    /*Implicit getters / setters*/
    func setStyle(_ style:Stylable)
    func setSkinState(_ state:String)
    func setSize(_ width:CGFloat, _ height:CGFloat)
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    /*Getters / Setters*/
    var decoratables:[GraphicDecoratableKind]{get}
    var style:Stylable?{get}
    var state:String{get}
    var parent:ElementKind?{get}/*We use IElement here instead of Element because sometimes we need to use Window which is not an Element but impliments IElement*/
//    var width:CGFloat?{get}
//    var height:CGFloat?{get}
    var hasChanged:HasChanged {get}
    var skinSize:CGSize?{get set}
//    var hasStyleChanged:Bool{get}
//    var hasStateChanged:Bool{get}
//    var hasSizeChanged:Bool{get}
}


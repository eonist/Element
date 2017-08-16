import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Rename to Skinable or SkinKind
 */
protocol Skinable:class{
    /*Implicit getters / setters*/
    func setStyle(_ style:Stylable)
    func setSkinState(_ state:String)
    func setSize(_ width:CGFloat, _ height:CGFloat)
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    /*Getters / Setters*/
    var decoratables:[GraphicDecoratableKind]{get set}
    var style:Stylable?{get set}
    var state:String{get set}
    var element:ElementKind?{get}/*We use IElement here instead of Element because sometimes we need to use Window which is not an Element but impliments IElement*/
    var width:CGFloat?{get}
    var height:CGFloat?{get}
    var hasStyleChanged:Bool{get}
    var hasStateChanged:Bool{get}
    var hasSizeChanged:Bool{get}
}

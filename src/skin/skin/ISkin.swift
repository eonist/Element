import Foundation

protocol ISkin:class{
    /*core methods*/
    /*implicit getters / setters*/
    func setStyle(style:IStyle)
    func setSkinState(state:String)
    func setSize(width:CGFloat, _ height:CGFloat)
    func getWidth()->CGFloat
    func getHeight()->CGFloat
    /*getters / setters*/
    var decoratables:Array<IGraphicDecoratable>{get set}
    var style:IStyle?{get}
    var state:String{get set}
    var element:IElement?{get}/*We use IElement here instead of Element because sometimes we need to use Window which is not an Element but impliments IElement*/
    var width:CGFloat?{get}
    var height:CGFloat?{get}
    var hasStyleChanged:Bool{get}
    var hasStateChanged:Bool{get}
    var hasSizeChanged:Bool{get}
    
}
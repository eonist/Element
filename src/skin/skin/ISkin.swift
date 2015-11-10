import Foundation

protocol ISkin{
    var style:IStyle?{get}
    var state:String{get set}
    var element:IElement?{get}/*We use IElement here instead of Element because sometimes we need to use Window which is not an Element but impliments IElement*/
    var width:Double?{get}
    var height:Double?{get}
    var hasStyleChanged:Bool{get}
    var hasStateChanged:Bool{get}
    var hasSizeChanged:Bool{get}
}
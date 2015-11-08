import Foundation

protocol ISkin{
    var style:IStyle?{get}
    var state:String{get set}
    var element:IElement?{get}
    var hasStyleChanged:Bool{get}
    var hasStateChanged:Bool{get}
    var hasSizeChanged:Bool{get}
}
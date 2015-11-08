import Foundation

protocol ISkin{
    var style:IStyle?{get set}
    var state:String{get set}
    var element:IElement?{get set}
}
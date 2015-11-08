import Foundation


class Skin:ISkin{
    var style:IStyle?
    var state:String
    var element:IElement?
    init(style:IStyle? = nil, state:String = "", element:IElement? = nil){
        self.style = style;
        self.state = state;
        self.element = element;
    }
}
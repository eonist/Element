import Foundation


class Skin{
    init(style:IStyle? = nil, state:String = "", element:IElement? = nil){
        _style = style;
        _state = state;
        _element = element;
    }
}
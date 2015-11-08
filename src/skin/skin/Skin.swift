import Foundation


class Skin{
    private var style:IStyle?
    private var state:String
    private var element:IElement?
    init(style:IStyle? = nil, state:String = "", element:IElement? = nil){
        self.style = style;
        self.state = state;
        self.element = element;
    }
}
import Foundation


class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        super.decoratable = GraphicSkinParser.configure(self);
        
    }
    override func draw(){
        
    }
}
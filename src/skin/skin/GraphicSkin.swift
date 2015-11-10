import Foundation


class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        super.decoratable = GraphicSkinParser.configure(self);
        
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw() NOT IMPLEMENTED YET")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            
        }
    }
    func applyProperties(decoratable:IDecoratable){
        //Swift.print("GraphicSkin.applyProperties() NOT IMPLEMENTED YET")
    }
}
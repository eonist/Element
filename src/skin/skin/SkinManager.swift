import Foundation
class SkinManager{
    /**
    * Returns a new SkinClass instance
    */
    func getSkinInstance(skinName:String,element:IElement,style:IStyle)->ISkin{
        switch skinName{
            case SkinFactory.graphicsSkin : return GraphicSkin(element.width,element.height,style,element.skin!.state!)
            case SkinFactory.textSkin : fatalError("NOT IMPLEMENTED YET")
            default: break;
        }
    }
}
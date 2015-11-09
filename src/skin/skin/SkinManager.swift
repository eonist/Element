import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    class func getSkinInstance(skinName:String,_ element:IElement, _ style:IStyle)->ISkin?{
        switch skinName{
            case SkinFactory.graphicsSkin : return GraphicSkin(style, element.skin!.state, element)
            case SkinFactory.textSkin : fatalError("NOT IMPLEMENTED YET")
            default: fatalError("NOT IMPLEMENTED YET")
        }
    }
}
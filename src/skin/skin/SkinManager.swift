import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    static func getSkinInstance(skinName:String,_ element:IElement, _ style:IStyle)->ISkin?{
        switch skinName{
            case SkinFactory.graphicsSkin : return GraphicSkin(style, element.getSkinState(), element)
            case SkinFactory.textSkin : return TextSkin(style, (element as! IText).initText, element.getSkinState(), element)
            default: fatalError("NOT IMPLEMENTED YET")
        }
    }
}
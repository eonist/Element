import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    static func skin(_ skinName:String, _ element:IElement, _ style:IStyle)->Skin?{
        switch skinName{
            case SkinFactory.graphicsSkin :
                return GraphicSkin(style, element.getSkinState(), element)
            case SkinFactory.textSkin :
                return TextSkin(style, (element as! IText).initText, element.getSkinState(), element)
            default:
                fatalError("NOT IMPLEMENTED YET")
        }
    }
}

import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    static func skin(by skinName:String, for element:IElement, with style:IStyle)->Skin?{
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

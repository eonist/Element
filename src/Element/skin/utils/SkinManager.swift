import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    static func skin(skinName:String, element:ElementKind, style:Stylable)->Skin?{
        switch skinName{
            case SkinFactory.graphicsSkin :
                return GraphicSkin(style, element.skinState/*, element*/)
            case SkinFactory.textSkin :
                return TextSkin(style, (element as! TextKind).initText, element.skinState/*, element*/)
            default:
                fatalError("NOT IMPLEMENTED YET")
        }
    }
}

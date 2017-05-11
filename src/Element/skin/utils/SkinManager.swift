import Foundation
class SkinManager{
    /**
     * Returns a new SkinClass instance
     */
    static func getSkinInstance(_ skinName:String,_ element:IElement, _ style:IStyle)->ISkin?{
        Swift.print("skinName: " + "\(skinName)")
        Swift.print("element: " + "\(element)")
        Swift.print("style: " + "\(style)")
        switch skinName{
            case skinName == SkinFactory.graphicsSkin :
                return GraphicSkin(style, element.getSkinState(), element)
            case SkinFactory.textSkin :
                return TextSkin(style, (element as! IText).initText, element.getSkinState(), element)
            default:
                fatalError("NOT IMPLEMENTED YET")
        }
    }
}

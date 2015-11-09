import Foundation
class SkinManager{
    /**
    * Returns a new SkinClass instance
    */
    func getSkinInstance(skinName:String,element:IElement,style:IStyle):Skin{
        switch skinName{
            case SkinFactory.graphicsSkin : SkinClass(element.width,element.height,style,element.skin.state);
        }
    
        if(skin is Function) return skin(element,style);
        else if (skin is Class) return Util.skinClassInstance(skin,element,style);
        else return null;
    }
}
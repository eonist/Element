import Foundation
/*
 * This is the default skinfactory for Element make your own or mix and match with decorator classes.
 * TODO: remove ...skin in the skin cosntant names
 * TODO: make SkinFactory work with Decorator pattern. mixing skins with each other etc (Extending is simpler and it works now) could be usefull when it comes to bevel dropshadow etc
 * TODO: create TextFormat skins multiline input pixel etc
 * TODO: create an EmptySkin that also
 */
class SkinFactory{
    static var graphicsSkin:String = "graphicSkin"//TODO: we could use Skin(GraphicSkin) instead of this variable
    static var textSkin:String = "textSkin"
    /*
    static func graphicSkin(element:IElement,style:IStyle)->ISkin {
        return GraphicSkin(style, element.getSkinState(), element);
    }
    */
    /*
    static func textSkin(element:IElement,style:IStyle)->ISkin {
        //fatalError("NOT IMPLEMENTED YET")
        return TextSkin(style,(element as! IText).initText, element.getSkinState(),element);
    }
    */
}
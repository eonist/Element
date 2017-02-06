import Foundation
/*
* TODO: should be able to return an empty skin, sometimes an empty skin is what you want
* TODO: use Vector<String> for speed etc?
*/
class SkinResolver{
    /**
     *  Returns a Skin instance
     *  TODO: future additions? //resolveSkinFromStylabaleParents(stylable) || resolveSkinByClass(stylable) || resolveSkinBySuperClass(stylable) || resolveSkinByDeafultStyling(stylable)
     * 	TODO: enable these additions when you have more controll over the Element FrameWork for now you need to throw error to debug
     */
    static func skin(_ element:IElement)->ISkin?{
        let style:IStyle = StyleResolver.style(element)
        //Swift.print("style: " + style)
        let skinName:String = style.getValue("skin") as? String ?? Utils.skinName(element)
        //Swift.print("SkinResolver.skin() skinName: " + skinName)
        return SkinManager.getSkinInstance(skinName,element,style) ?? resolveError(style,element)
    }
    /**
     * Throws an error message if a skin cant be resolved (with usefull information for debugging)
     */
    static func resolveError(_ style:IStyle, _ element:IElement)->ISkin {
        //Swift.print("with parent: " + (element.parent || ""))
        //Swift.print("with skin: "+element.skin || "")
        //Swift.print("with style.selector: "+style.name || "")//could have to be altred
        fatalError("SKINRESOLVER: NO SKIN COULD BE RESOLVED FOR ELEMENT BY THE ID: "/* + element.id*/)
    }
}
private class Utils{
    /**
     * Returns a skin name based on what class type the element parent is
     */
    static func skinName(_ element:IElement)->String {
        var skinName:String;
        switch element.getClassType(){
            case "Text":skinName = SkinFactory.textSkin
            default:skinName = SkinFactory.graphicsSkin
        }
        return skinName
    }
}

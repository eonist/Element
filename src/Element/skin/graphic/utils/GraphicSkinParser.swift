import Foundation
@testable import Utils

/**
 * Parser for "decoratable"
 */
 class GraphicSkinParser{
    /**
     * TODO: ⚠️️ Should just use the instance setSize function
     * TODO: ⚠️️ Should only be called if the size has actually changed
     */
    static func size(_ skin:Skinable,_ depth:Int)->CGSize{
        let padding:Padding = Padding()//StylePropertyParser.padding(self,depth) //StylePropertyParser.padding(self,depth);// :TODO: what about margin?<----not sure this is needed, the padding
        let width:CGFloat = GraphicSkinParser.width(skin,depth,padding)
        let height:CGFloat = GraphicSkinParser.height(skin,depth,padding)
        return CGSize(width,height)
    }
    /**
     * Derives the width from CSS
     */
    static func width(_ skin:Skinable,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StyleMetricParser.width(skin,depth) ?? skin.parent?.frame.w ?? {fatalError("err")}()/*skin.skinSize!.width*/) + padding.hor// :TODO: only querry this if the size has changed?
    }
    /**
     * Derives the height from CSS
     */
    static func height(_ skin:Skinable,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StyleMetricParser.height(skin,depth) ?? skin.parent?.frame.h ?? {fatalError("err")}() /*skin.skinSize!.height*/) + padding.ver// :TODO: only querry this if the size has changed?
    }
}


import Foundation


class GraphicSkinParser{
   static var rect:String = "rect";
   static var gradient:String = "gradient";
   static var icon:String = "icon";// :TODO: rename to asset or svgasset or alike (keep in mind that you will need to support png assets soon enough)
   static var fillet:String = "fillet";// :TODO: rename to ROUNDED?
   static var dropshadow:String = "dropshadow";
    /**
    * Returns a Decoratable instance based on what stylePropertyValues is found in @param skin at @param depth
    */
    class func configure(skin:ISkin)->IDecoratable {
        let fillStyle:IFillStyle = StylePropertyParser.fillStyle(skin);
        var decoratable:IDecoratable = Utils.rectGraphic(skin,fillStyle);
        if(StylePropertyAsserter.hasFillet(skin)) {
            Swift.print("hasFillet")
            decoratable = Utils.fillet(decoratable, StylePropertyParser.fillet(skin));
        }
        return decoratable
    }
}
private class Utils{
    /**
     * Returns a "GraphicRect instance"
     * @example: var r:Rect2 = new Rect2(20,20,new FillStyle());//black square
     */
    class func rectGraphic(skin:ISkin,_ fillStyle:IFillStyle)->IDecoratable {
        let width:Double = (StylePropertyParser.width(skin) ?? skin.width!);
        let height:Double = (StylePropertyParser.height(skin) ?? skin.height!);
        return RectGraphic(width,height,fillStyle);
    }
    /**
     * Returns a "RoundDecorator instance" wrapped around a Rect instance
     * // :TODO: Future feature: support for fillOffset, and cornerradius and fillet should have the same nameing scheme
     */
    class func fillet(decoratable:IDecoratable,_ fillet:Fillet? = nil)->IDecoratable {
        return RoundRectGraphic(decoratable, fillet)
    }
}
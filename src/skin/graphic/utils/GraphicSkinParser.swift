import Foundation
@testable import Utils

class GraphicSkinParser{
   static var rect:String = "rect"
   static var gradient:String = "gradient"
   static var icon:String = "icon"//TODO: rename to asset or svgasset or alike (keep in mind that you will need to support png assets soon enough)
   static var fillet:String = "fillet"//TODO: rename to rounded?
   static var dropshadow:String = "dropshadow"
    /**
     * Configures a GraphicDecoratable instance based on what stylePropertyValues is found in PARAM: skin at PARAM: depth
     */
    static func configure(_ skin:ISkin,_ depth:Int)->IGraphicDecoratable{
        let fillStyle:IFillStyle = StylePropertyParser.fillStyle(skin,depth);//<-----TODO:this should be optional like lineStyle
        let lineStyle:ILineStyle? = StylePropertyParser.lineStyle(skin,depth);
        var graphic:IGraphicDecoratable = Utils.baseGraphic(skin,fillStyle,lineStyle,depth)
        graphic = Utils.rectGraphic(skin,graphic,depth)
        if(StylePropertyAsserter.hasFillet(skin,depth)) { graphic = Utils.fillet(graphic, StylePropertyParser.fillet(skin,depth)) }
        if(StylePropertyAsserter.hasGradient(skin,depth)) { graphic = Utils.gradient(graphic) }
        if(StylePropertyAsserter.hasAsset(skin,depth)) { graphic = Utils.asset(graphic, StylePropertyParser.asset(skin,depth)) }
        if(StylePropertyAsserter.hasDropShadow(skin,depth)) {graphic = Utils.dropShadow(graphic, StylePropertyParser.dropShadow(skin,depth))}
        return graphic
    }
}
private class Utils{
    static func baseGraphic(_ skin:ISkin, _ fillStyle:IFillStyle,_ lineStyle:ILineStyle?,_ depth:Int = 0)->IGraphicDecoratable {
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin,depth);
        //Swift.print("lineOffsetType: top:" + lineOffsetType.top + "  left:" + lineOffsetType.left + " bottom: " + lineOffsetType.bottom + " right: "+lineOffsetType.right)
        return BaseGraphic(fillStyle,lineStyle,lineOffsetType)
    }
    /**
     * Returns a "GraphicRect instance"
     */
    static func rectGraphic(_ skin:ISkin, _ decoratable:IGraphicDecoratable,_ depth:Int = 0)->IGraphicDecoratable {
        let padding:Padding = Padding()//StylePropertyParser.padding(skin,depth)
        let width:CGFloat = (StylePropertyParser.width(skin,depth) ?? skin.width!)  + padding.left + padding.right
        let height:CGFloat = (StylePropertyParser.height(skin,depth) ?? skin.height!) + padding.top + padding.bottom
        /*var lineOffset:OffsetType = StylePropertyParser.lineOffsetType(skin,depth);*///I guess this wasnt needed anymore since the line offset is a bit simpler than legacy code?
        return RectGraphic(width,height,decoratable)
    }
   
    /**
     * NOTE: asset is svg for now but in the future it should support png
     * TODO: this solution isnt perfect but it works for now
     */
    static func asset(_ decoratable:IGraphicDecoratable,_ asset:String)->IGraphicDecoratable {
        return AssetDecorator(decoratable, asset)
    }
    /**
     * Returns a "RoundRectGraphic instance" wrapped around a Rect instance
     * TODO: Future feature: support for fillOffset, and cornerradius and fillet should have the same nameing scheme
     */
    static func fillet(_ decoratable:IGraphicDecoratable,_ fillet:Fillet)->IGraphicDecoratable {
        //Swift.print("GraphicSkinParser.fillet()")
        return RoundRectGraphic(decoratable, fillet)
    }
    /**
     * Returns a "GradientDecorator instance" wrapped around a PARAM: decoratable
     * NOTE: to use a custom matrix, pass a matrix with the PARAM: gradient or PARAM: lineGradient
     * NOTE: doesnt drawLine by default, pass a Gradient instance with PARAM: lineGradient to draw a gradientLine
     * // :TODO: support for GradientLineStyle, GradientFillStyle
     */
    static func gradient(_ decoratable:IGraphicDecoratable)->IGraphicDecoratable{
        return GradientGraphic(decoratable)
    }
    /**
     * Wraps a DropShadowDecorator instance on PARAM: decoratable
     */
    static func dropShadow(_ decoratable:IGraphicDecoratable, _ dropShadow:DropShadow?)->IGraphicDecoratable {
        return DropShadowDecorator(decoratable,dropShadow)
    }
}

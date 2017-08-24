import Foundation
@testable import Utils

class GraphicSkinParser{
    /**
     * Configures a GraphicDecoratable instance based on what stylePropertyValues is found in PARAM: skin at PARAM: depth
     */
    static func configure(_ skin:Skinable,_ depth:Int)->GraphicDecoratableKind{
        let fillStyle:FillStyleKind = StylePropertyParser.fillStyle(skin,depth)//<--TODO:this should be optional like lineStyle
        let lineStyle:LineStylable? = StylePropertyParser.lineStyle(skin,depth)
        var graphic:GraphicDecoratableKind = Utils.baseGraphic(skin,fillStyle,lineStyle,depth)
        graphic = Utils.rectGraphic(skin,graphic,depth)
        if StylePropertyAsserter.hasFillet(skin,depth) {graphic = Utils.fillet(graphic, StyleMetricParser.fillet(skin,depth)) }
        if StylePropertyAsserter.hasGradient(skin,depth) {graphic = Utils.gradient(graphic) }
        if StylePropertyAsserter.hasAsset(skin,depth) {graphic = Utils.asset(graphic, StylePropertyParser.asset(skin,depth)) }
        if StylePropertyAsserter.hasDropShadow(skin,depth) {graphic = Utils.dropShadow(graphic, StylePropertyParser.dropShadow(skin,depth))}
        return graphic
    }
}
private class Utils{
    static func baseGraphic(_ skin:Skinable, _ fillStyle:FillStyleKind,_ lineStyle:LineStylable?,_ depth:Int = 0)->GraphicDecoratableKind {
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin,depth)
        return BaseGraphic(fillStyle,lineStyle,lineOffsetType)
    }
    /**
     * Returns a "GraphicRect instance"
     */
    static func rectGraphic(_ skin:Skinable, _ decoratable:GraphicDecoratableKind,_ depth:Int = 0)->GraphicDecoratableKind {
        let padding:Padding = Padding()//StylePropertyParser.padding(skin,depth)
        let width:CGFloat = {
            var padding:CGFloat {return padding.left + padding.right}
            if let styleWidth:CGFloat = StyleMetricParser.width(skin,depth){
                return styleWidth + padding
            }else if !skin.skinSize!.width.isNaN{
                return skin.skinSize!.width + padding
            }
            fatalError("not allowed: styleWidth: \(StyleMetricParser.width(skin,depth)!) skinWidth: \(skin.skinSize!.width)")
        }()
        let height:CGFloat = (StyleMetricParser.height(skin,depth) ?? skin.skinSize!.height) + padding.top + padding.bottom
        /*var lineOffset:OffsetType = StylePropertyParser.lineOffsetType(skin,depth);*///I guess this wasnt needed anymore since the line offset is a bit simpler than legacy code?
//        Swift.print(CGSize(width,height))
        return RectGraphic.init(CGPoint(), CGSize(width,height), decoratable)
    }
   
    /**
     * NOTE: asset is svg for now but in the future it should support png
     * TODO: ⚠️️ this solution isn't perfect but it works for now
     */
    static func asset(_ decoratable:GraphicDecoratableKind,_ assetURL:String)->GraphicDecoratableKind {
        return AssetDecorator(decoratable, assetURL)
    }
    /**
     * Returns a "RoundRectGraphic instance" wrapped around a Rect instance
     * TODO: ⚠️️ Future feature: support for fillOffset, and cornerradius and fillet should have the same nameing scheme
     */
    static func fillet(_ decoratable:GraphicDecoratableKind,_ fillet:Fillet)->GraphicDecoratableKind {
        return RoundRectGraphic(decoratable, fillet)
    }
    /**
     * Returns a "GradientDecorator instance" wrapped around a PARAM: decoratable
     * NOTE: to use a custom matrix, pass a matrix with the PARAM: gradient or PARAM: lineGradient
     * NOTE: doesnt drawLine by default, pass a Gradient instance with PARAM: lineGradient to draw a gradientLine
     * TODO: ⚠️️ support for GradientLineStyle, GradientFillStyle
     */
    static func gradient(_ decoratable:GraphicDecoratableKind)->GraphicDecoratableKind{
        return GradientGraphic(decoratable)
    }
    /**
     * Wraps a DropShadowDecorator instance on PARAM: decoratable
     */
    static func dropShadow(_ decoratable:GraphicDecoratableKind, _ dropShadow:DropShadow?)->GraphicDecoratableKind {
        return DropShadowDecorator(decoratable,dropShadow)
    }
}

//static var rect:String = "rect"
//static var gradient:String = "gradient"
//static var icon:String = "icon"//TODO: rename to asset or svgasset or alike (keep in mind that you will need to support png assets soon enough)
//static var fillet:String = "fillet"//TODO: rename to rounded?
//static var dropshadow:String = "dropshadow"

import Cocoa

class GraphicModifier {
    /**
     * TODO: fill and linestyle should be graphic spessific see original code
     */
    class func applyProperties(inout decoratable:IGraphicDecoratable,_ fillStyle:IFillStyle,_ lineStyle:ILineStyle?,_ offsetType:OffsetType)->IGraphicDecoratable {
        decoratable.graphic.fillStyle = fillStyle;
        decoratable.graphic.lineStyle = lineStyle;
        decoratable.graphic.lineOffsetType = offsetType;
        return decoratable;
    }
}
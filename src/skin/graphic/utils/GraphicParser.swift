import Foundation

class GraphicParser {
    /**
     * NOTE: universal initiator for any mix of FillStyle,LineStyle,GradientFillStyle,GradientLineStyle,nil
     * NOTE: one init method that would take IFillStyle and ILineStyle and then make a if decision tree to which Graphic should be created.
     */
    class func graphic(fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffset:OffsetType = OffsetType(OffsetType.center))->IGraphicDecoratable{
        let graphic:IGraphicDecoratable = fillStyle is IGradientFillStyle || lineStyle is IGradientLineStyle ? GradientGraphic(BaseGraphic(fillStyle,lineStyle,lineOffset)) : BaseGraphic(fillStyle,lineStyle,lineOffset)
        return graphic
    }
}

import Foundation

class GraphicParser {
    /**
     * NOTE: universal initiator for any mix of FillStyle,LineStyle,GradientFillStyle,GradientLineStyle,nil
     * NOTE: one init method that would take IFillStyle and ILineStyle and then make a if decision tree to which Graphic should be created.
     */
    class func graphic(fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffset:OffsetType = OffsetType(OffsetType.center))->IGraphicDecoratable{
        var graphic:IGraphicDecoratable
        if(fillStyle is IGradientFillStyle){
            if(lineStyle is IGradientLineStyle){graphic = GradientGraphic(BaseGraphic(fillStyle as? IGradientFillStyle,lineStyle as? IGradientLineStyle,lineOffset))}/*gradientFill,gradientLine*/
            else{graphic = GradientGraphic(BaseGraphic(fillStyle as? IGradientFillStyle,lineStyle,lineOffset))}/*gradientFill,line*/
        }else{
            if(lineStyle is IGradientLineStyle){graphic = GradientGraphic(BaseGraphic(fillStyle,lineStyle as? IGradientLineStyle,lineOffset))}/*fill,gradientLine*/
            else{graphic = BaseGraphic(fillStyle,lineStyle,lineOffset)}/*fill,line*/
        }
        return graphic
    }
}

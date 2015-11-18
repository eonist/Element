import Foundation

class RectGraphic:GraphicDecoratable{
    /**
     *
     */
    override func drawFill() {
        var x:Number = lineOffsetType.left == OffsetType.OUTSIDE ? lineStyle.thickness : 0;
        var y:Number = lineOffsetType.top == OffsetType.OUTSIDE ? lineStyle.thickness : 0;
        getGraphic().path = CGPathParser.rect(CGFloat(getGraphic().width), CGFloat(getGraphic().height))
    }
    /**
     *
     */
    func drawLine(){
        Swift.print("RectGraphic.drawLine()")
        if(getGraphic().lineStyle != nil){
            let rect:CGRect = RectGraphicUtils.offsetRect(CGRect(0, 0, graphic.width, graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //drawLine
            //lineShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
            let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0, graphic.width,graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //draw the mask line
            //lineMask.graphics.drawRect(maskRect.x, maskRect.y, maskRect.width, maskRect.height);
        }
    }
}

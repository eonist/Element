import Foundation

class RectGraphic:GraphicDecoratable{
    /**
     *
     */
    override func drawFill() {
        let x:CGFloat = graphic.lineOffsetType!.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        let y:CGFloat = graphic.lineOffsetType!.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        getGraphic().path = CGRect(x,y,graphic.width, graphic.height).path
    }
    /**
     *
     */
    func drawLine(){
        Swift.print("RectGraphic.drawLine()")
        if(getGraphic().lineStyle != nil){
            let rect:CGRect = RectGraphicUtils.offsetRect(CGRect(0.0, 0.0, graphic.width, graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //drawLine
            //lineShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
            let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0.0,0.0, graphic.width,graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //draw the mask line
            //lineMask.graphics.drawRect(maskRect.x, maskRect.y, maskRect.width, maskRect.height);
        }
    }
}

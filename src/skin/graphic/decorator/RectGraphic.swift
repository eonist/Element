import Foundation

class RectGraphic:GraphicDecoratable{
    /**
     *
     */
    override func drawFill() {
        let x:CGFloat = graphic.lineOffsetType!.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        let y:CGFloat = graphic.lineOffsetType!.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        graphic.path = CGRect(x,y,graphic.width, graphic.height).path
    }
    /**
     *
     */
    override func drawLine(){
        Swift.print("RectGraphic.drawLine()")
        if(graphic.lineStyle != nil){
            let graphicRect:CGRect = CGRect(0, 0, graphic.width, graphic.height)
            
            Swift.print("graphicRect: " + String(graphicRect))
            let rect:CGRect = RectGraphicUtils.offsetRect(), graphic.lineStyle!, graphic.lineOffsetType!);
            Swift.print("rect: " + String(rect))
            
            //drawLine
            let x:CGFloat = graphic.lineOffsetType!.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
            let y:CGFloat = graphic.lineOffsetType!.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
            graphic.linePath = CGRect(x,y,graphic.width, graphic.height).path
            //graphic.linePath = rect.path
            
            
            //lineShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
            //let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0, graphic.width,graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //draw the mask line
            //lineMask.graphics.drawRect(maskRect.x, maskRect.y, maskRect.width, maskRect.height);
        }
    }
}

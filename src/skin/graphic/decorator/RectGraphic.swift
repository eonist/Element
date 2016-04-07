import Cocoa
/**
 * NOTE: the reason this class extends SizeableGraphic and not SizeableDecorator is because SizeableDecorator doesnt hold any size, it merly passes the size that the instance it decorates holds. Same goes for PositionalDecorator
 */
class RectGraphic:SizeableGraphic{
    /**
     * TODO: make the CGRect(x,y,width,height) into a variable on the Graphic class
     */
    override func drawFill() {
        //Swift.print("RectGraphic.drawFill()")
        graphic.fillShape.path = CGRect(0,0,width,height).path/*Draws in the local coordinate space of the shape*/
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!.thickness, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        //Swift.print("graphic.fillShape.frame: " + "\(graphic.fillShape.frame)")
    }
    /**
     *
     */
    override func drawLine(){
        //Swift.print("RectGraphic.drawLine()")
        if(graphic.lineStyle != nil){/*<---TODO: I dont think this check is needed, as this check is already done in the GraphicDecoratable class, so remove it when your working with this again*/
            //let graphicRect:CGRect = CGRect(0, 0, width, height)
            
            //Swift.print("graphicRect: " + String(graphicRect))
            //let rect:CGRect = RectGraphicUtils.offsetRect(graphicRect, graphic.lineStyle!, graphic.lineOffsetType);
            //Swift.print("rect: " + String(rect))
            let lineOffsetRect = RectGraphicUtils.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!.thickness, graphic.lineOffsetType)
            //let offsetRects = RectGraphicUtil.offsetRect(graphic.fillShape.frame.copy(), graphic.lineStyle!, graphic.lineOffsetType)
            
            //Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
            graphic.lineShape.frame = lineOffsetRect.lineFrameRect
            
            
            //Swift.print("offsetRects.lineRect: " + "\(lineOffsetRect.lineRect)")
            graphic.lineShape.path = lineOffsetRect.lineRect.path//rect.path
            
            
            //lineShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
            //let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0, graphic.width,graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //draw the mask line
            //lineMask.graphics.drawRect(maskRect.x, maskRect.y, maskRect.width, maskRect.height);
        }
    }
}
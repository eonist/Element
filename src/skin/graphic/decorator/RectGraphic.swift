import Cocoa

class RectGraphic:SizeableGraphic{
    /**
     *
     */
    override func drawFill() {
        /*
        var x:CGFloat = graphic.lineOffsetType.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        var y:CGFloat = graphic.lineOffsetType.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        x += self.x
        y += self.y
        let rect:CGRect = CGRect(x,y,width, height)
        graphic.fillShape.path = rect.path
        */
        graphic.fillShape.path = CGRect(0,0,width,height).path/*Draws in the local coordinate space of the shape*/
        let fillOffsetRect = RectGraphicUtils2.fillOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
        graphic.fillShape.frame = fillOffsetRect/*,position and set the size of the frame*/
        Swift.print("graphic.fillShape.frame: " + "\(graphic.fillShape.frame)")
    }
    /**
     *
     */
    override func drawLine(){
        //Swift.print("RectGraphic.drawLine()")
        if(graphic.lineStyle != nil){
            //let graphicRect:CGRect = CGRect(0, 0, width, height)
            
            //Swift.print("graphicRect: " + String(graphicRect))
            //let rect:CGRect = RectGraphicUtils.offsetRect(graphicRect, graphic.lineStyle!, graphic.lineOffsetType);
            //Swift.print("rect: " + String(rect))
            let lineOffsetRect = RectGraphicUtils2.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
            //let offsetRects = RectGraphicUtil.offsetRect(graphic.fillShape.frame.copy(), graphic.lineStyle!, graphic.lineOffsetType)
            
            Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
            graphic.lineShape.frame = lineOffsetRect.lineFrameRect
            
            
            Swift.print("offsetRects.lineRect: " + "\(lineOffsetRect.lineRect)")
            graphic.lineShape.path = lineOffsetRect.lineRect.path//rect.path
            
            
            //lineShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
            //let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0, graphic.width,graphic.height), graphic.lineStyle!, graphic.lineOffsetType!);
            //draw the mask line
            //lineMask.graphics.drawRect(maskRect.x, maskRect.y, maskRect.width, maskRect.height);
        }
    }
}


/*

func setSize(width:CGFloat,height:CGFloat) {
self.width = width;
self.height = height;
}

*/

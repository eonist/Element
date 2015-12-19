import Foundation

class RectGraphicUtils2 {
    /**
     * New
     * NOTE: you actually need two CGRects returned, one is for the stroke rect, and one is for framing the stroke rect
     * NOTE: you also need to return a CGRect for the frame of the skin and the frame of the Element aswell. (same frame)
     */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineFrameRect:CGRect,lineRect:CGRect,fillRect:CGRect){
        var lineFrameRect:CGRect = rect.copy()
        var lineRect:CGRect = rect.copy()
        var fillRect:CGRect = rect.copy()
        
        Swift.print("lineRect: " + "\(lineRect)")
        /*Left*/
        if(offsetType.left == OffsetType.outside){
            //lineFrameRect = rect.expand(lineStyle.thickness, lineStyle.thickness)
            lineRect = lineRect.offset(lineStyle.thickness / 2, 0).expand(-lineStyle.thickness/2, 0)
            fillRect = fillRect.offset(lineStyle.thickness, 0)
        }else { //inside
            lineRect = lineRect.offset(-lineStyle.thickness/2, 0).expand(lineStyle.thickness/2 , 0)
        }
        /*Right*/
        if(offsetType.right == OffsetType.outside){
            //lineFrameRect = rect.expand(lineStyle.thickness, lineStyle.thickness)
            lineRect = lineRect.expand(-lineStyle.thickness/2 , 0)
        }else{//inside
            lineRect = lineRect.expand(lineStyle.thickness/2 , 0)
        }
        /*Top*/
        if(offsetType.top == OffsetType.outside){
            lineRect = lineRect.offset(0, lineStyle.thickness/2)//.expand(0,-lineStyle.thickness/2)
            fillRect = fillRect.offset(0,lineStyle.thickness)
            
        }else{//inside
            lineRect = lineRect.offset(0, -lineStyle.thickness/2).expand(0,+lineStyle.thickness/2)
        }
        /*Bottom*/
        if(offsetType.bottom == OffsetType.outside){//outside
            lineRect = lineRect.expand(0,-lineStyle.thickness/2)
        }else{//inside
            lineRect = lineRect.expand(0,+lineStyle.thickness/2)
        }
        //offset by half of thickness in x & y, then you expand it 1x the thickness
        
        //offset the fillRect with the thickness of the border in x & y dir
        
        return (lineFrameRect,lineRect, fillRect)
    }
}

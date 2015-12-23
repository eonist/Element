import Foundation

class RectGraphicUtils {
    /**
     *
     */
    class func fillFrame(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->CGRect{
        var fillFrameRect:CGRect = rect.copy()
        //Swift.print("lineRect: " + "\(lineRect)")
        /*Left*/
        if(!lineStyle.thickness.isNaN && offsetType.left == OffsetType.outside){
            fillFrameRect = fillFrameRect.offset(lineStyle.thickness, 0)
        }
        /*Top*/
        if(!lineStyle.thickness.isNaN && offsetType.top == OffsetType.outside){
            fillFrameRect = fillFrameRect.offset(0,lineStyle.thickness)
        }
        return fillFrameRect
    }
    /**
     * 
     */
    class func lineOffsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineFrameRect:CGRect,lineRect:CGRect){
        var lineFrameRect:CGRect = rect.copy()
        var lineRect:CGRect = CGRect(0,0,rect.width,rect.height)
        //Swift.print("lineRect: " + "\(lineRect)")
        /*Left*/
        if(offsetType.left == OffsetType.outside){
            lineFrameRect = lineFrameRect.expand(lineStyle.thickness, 0)
            lineRect = lineRect.offset(lineStyle.thickness / 2, 0)//.expand(-lineStyle.thickness/2, 0)
        }else if(offsetType.left == OffsetType.inside){ //inside
            lineRect = lineRect.offset(-lineStyle.thickness/2, 0)//.expand(lineStyle.thickness/2 , 0)
        }
        /*Right*/
        if(offsetType.right == OffsetType.outside){
            lineFrameRect = lineFrameRect.expand(lineStyle.thickness, 0)
            lineRect = lineRect.expand(lineStyle.thickness , 0)
        }else if(offsetType.left == OffsetType.inside){//inside
            lineRect = lineRect.expand(lineStyle.thickness , 0)
        }else{
            
        }
        /*Top*/
        if(offsetType.top == OffsetType.outside){
            lineFrameRect = lineFrameRect.expand(0,lineStyle.thickness)
            lineRect = lineRect.offset(0, lineStyle.thickness/2)//.expand(0,-lineStyle.thickness/2)
        }else if(offsetType.left == OffsetType.inside){//inside
            lineRect = lineRect.offset(0, -lineStyle.thickness/2)//.expand(0,+lineStyle.thickness/2)
        }
        /*Bottom*/
        if(offsetType.bottom == OffsetType.outside){//outside
            lineFrameRect = lineFrameRect.expand(0,lineStyle.thickness)
            lineRect = lineRect.expand(0,lineStyle.thickness)
        }else if(offsetType.left == OffsetType.inside){//inside
            lineRect = lineRect.expand(0,lineStyle.thickness)
        }
        return (lineFrameRect,lineRect)
    }
}

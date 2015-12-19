import Foundation

class RectGraphicUtils2 {
    /**
     * New
     * NOTE: you actually need two CGRects returned, one is for the stroke rect, and one is for framing the stroke rect
     * NOTE: you also need to return a CGRect for the frame of the skin and the frame of the Element aswell. (same frame)
     */
    class func offsetRect2(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(frame:CGRect,line:CGRect,fill:CGRect){
        var lineFrameRect:CGRect
        var lineRect:CGRect
        var fillOffsetRect:CGRect
        if(offsetType == OffsetType(OffsetType.outside)){//outside
            //Expand by 2x the thickness of the border
            lineFrameRect = rect.expand(lineStyle.thickness * 2, lineStyle.thickness * 2)
            //offset by half of thickness in x & y, then you expand it 1x the thickness
            lineRect = rect.offset(lineStyle.thickness / 2, lineStyle.thickness / 2).expand(lineStyle.thickness, lineStyle.thickness)
            //offset the fillRect with the thickness of the border in x & y dir
            fillOffsetRect = rect.offset(lineStyle.thickness, lineStyle.thickness)
        }else{//inside
            //leave it as is
            lineFrameRect = rect.copy()
            //uniformally outset the lineFrameRect by half the border thickness
            lineRect = rect.outset(lineStyle.thickness / 2, lineStyle.thickness / 2)
            //dont do anything
            fillOffsetRect = rect.copy()
        }
        return (lineFrameRect,lineRect, fillOffsetRect)
    }
}

import Foundation

class RectGraphicUtils2 {
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineRect:CGRect, frameRect:CGRect) {
        let topLeft = Utils.corner(rect, lineStyle,offsetType,Alignment.topLeft);//cornerPoint(rect, Alignment.TOP_LEFT, offsetType.left, offsetType.top, lineStyle);
        //print("topLeft.frame: " + String(topLeft.frame));
        //print("topLeft.line: " + String(topLeft.line));
        let bottomRight = Utils.corner(rect, lineStyle,offsetType,Alignment.bottomRight);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        //print("bottomRight.frame: " + String(bottomRight.frame));
        //print("bottomRight.line: " + String(bottomRight.line));
        let frameRect:CGRect = Converter.convert(topLeft.frame,bottomRight.frame)
        let lineRect:CGRect = Converter.convert(topLeft.line,bottomRight.line)
        let convertedTopLeftPoint = Converter.pointToSpace(topLeft.line,lineRect,frameRect)
        //Swift.print("convertedTopLeftPoint: " + "\(convertedTopLeftPoint)")
        /*convert the point to the correct point space*/
        let convertedBottomRightPoint = Converter.pointToSpace(bottomRight.line,lineRect,frameRect)
        //Swift.print("convertedBottomRightPoint: " + "\(convertedBottomRightPoint)")
        var convertedLineRect:CGRect = Converter.convert(convertedTopLeftPoint,convertedBottomRightPoint)
        //Swift.print("lineRect: before" + "\(convertedLineRect)")
        /*convert to 0,0 pointspace*/
        convertedLineRect -= topLeft.line
        //Swift.print("lineRect: after" + "\(convertedLineRect)")
        return (convertedLineRect,frameRect)
    }
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
class 

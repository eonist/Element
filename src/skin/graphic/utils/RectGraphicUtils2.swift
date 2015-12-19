import Foundation

class RectGraphicUtils2 {
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineRect:CGRect, frameRect:CGRect, fillRect:CGRect) {
        let topLeft = Utils.corner(rect, lineStyle,offsetType,Alignment.topLeft);//cornerPoint(rect, Alignment.TOP_LEFT, offsetType.left, offsetType.top, lineStyle);
        //print("topLeft.frame: " + String(topLeft.frame));
        //print("topLeft.line: " + String(topLeft.line));
        let bottomRight = Utils.corner(rect, lineStyle,offsetType,Alignment.bottomRight);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        //print("bottomRight.frame: " + String(bottomRight.frame));
        //print("bottomRight.line: " + String(bottomRight.line));
        let frameRect:CGRect = Converter.convert(topLeft.frame,bottomRight.frame)
        let lineRect:CGRect = Converter.convert(topLeft.line,bottomRight.line)
        let fillRect:CGRect = Converter.convert(topLeft.fill,bottomRight.fill)
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
        return (convertedLineRect,frameRect, fillRect)
    }
}
class Utils{
    /**
     * NOTE: only supports topLeft and bottomRight
     * TODO: This code isnt Optimized, to optimize see the old code. (Requires individual side calculation and also some sides use the same math so some sides can be squasehd etc. Also reuse similar math etc) you can optimize by storing halfsizes etc
     */
    class func corner(rect:CGRect,_ lineStyle:ILineStyle,_ offsetType:OffsetType,_ cornerType:String)->(line:CGPoint,frame:CGPoint,fill:CGPoint){
        if(cornerType == Alignment.topLeft){
            let topOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.top))
            let leftOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.left))
            return (CGPoint(leftOffsetRect.lineRect.x,topOffsetRect.lineRect.y), CGPoint(leftOffsetRect.frameRect.x,topOffsetRect.frameRect.y),CGPoint(leftOffsetRect.fillRect.x,topOffsetRect.fillRect.y))
        }else{/*bottomRight*/
            let bottomOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.bottom))
            let rightOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.right))
            return (CGPoint(rightOffsetRect.lineRect.bottomRight.x,bottomOffsetRect.lineRect.bottomRight.y), CGPoint(rightOffsetRect.frameRect.bottomRight.x,bottomOffsetRect.frameRect.bottomRight.y),CGPoint(rightOffsetRect.fillRect.bottomRight.x,bottomOffsetRect.fillRect.bottomRight.y))
        }
    }
    /**
     * New
     * NOTE: you actually need two CGRects returned, one is for the stroke rect, and one is for framing the stroke rect
     * NOTE: you also need to return a CGRect for the frame of the skin and the frame of the Element aswell. (same frame)
     */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(frameRect:CGRect,lineRect:CGRect,fillRect:CGRect){
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
private class Converter{
    /**
     *
     */
    class func pointToSpace(p:CGPoint, _ from:CGRect, _ to:CGRect)->CGPoint{
        let difference = PointParser.difference(to.topLeft,from.topLeft)
        //Swift.print("difference: " + "\(difference)")
        return p + difference
    }
    
    /**
     * Converts topLeft corner and topRight corner to a CGRect instance
     */
    class func convert(tl:CGPoint,_ br:CGPoint)->CGRect{
        let x:CGFloat = tl.x;
        let y:CGFloat = tl.y;
        let width:CGFloat = br.x - tl.x;
        let height:CGFloat = br.y - tl.y;
        return CGRect(x, y, width, height);
    }
}

import Foundation

class RectGraphicUtil {
    /**
     * Returns a Tuple with "frame and line rects" by offsetting @param rect with @param lineOffset
     * NOTE: works with different side offsetType (left,right,top,bottom)
     * NOTE: inset = hidden, center = visible, outside = visible
     */
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
private class Utils{
    /**
     * NOTE: only supports topLeft and bottomRight
     * TODO: This code isnt Optimized, to optimize see the old code. (Requires individual side calculation and also some sides use the same math so some sides can be squasehd etc. Also reuse similar math etc) you can optimize by storing halfsizes etc
     */
    class func corner(rect:CGRect,_ lineStyle:ILineStyle,_ offsetType:OffsetType,_ cornerType:String)->(line:CGPoint,frame:CGPoint){
        if(cornerType == Alignment.topLeft){
            let topOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.top))
            let leftOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.left))
            return (CGPoint(leftOffsetRect.lineRect.x,topOffsetRect.lineRect.y), CGPoint(leftOffsetRect.frameRect.x,topOffsetRect.frameRect.y))
        }else{/*bottomRight*/
            let bottomOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.bottom))
            let rightOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.right))
            return (CGPoint(rightOffsetRect.lineRect.bottomRight.x,bottomOffsetRect.lineRect.bottomRight.y), CGPoint(rightOffsetRect.frameRect.bottomRight.x,bottomOffsetRect.frameRect.bottomRight.y))
        }
    }
    /**
     * Returns a Tuple with "frame and line rects" by offsetting @param rect with @param lineOffset
     * NOTE: only works when all sides are of the same offsetType
     */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineRect:CGRect, frameRect:CGRect) {
        var lineRect:CGRect = CGRect()
        var frameRect:CGRect = CGRect()
        let thickness:CGFloat = lineStyle.thickness
        if(offsetType == OffsetType(OffsetType.center)){/*Asserts if all props of the lineOffsetType is of the center type*/
            frameRect = rect.outset(thickness/2, thickness/2)/*frame*/
            lineRect = rect.copy()//CGRect(0,0,rect.width,rect.height) + CGPoint(thickness/2, thickness/2)
        }else if(offsetType == OffsetType(OffsetType.inside)){/*inside*/
            frameRect = rect.copy()/*frame*/
            lineRect = rect.outset(thickness/2, thickness/2)//CGRect(0,0,rect.width,rect.height).inset(thickness/2, thickness/2) /*line*/
        }else{/*outside*/
            frameRect = rect.outset(thickness, thickness) /*frame*/
            lineRect = rect.outset(thickness/2, thickness/2)//CGRect(-thickness/2,-thickness/2,rect.width+thickness,rect.height+thickness)/*line, you expand the rect in the 0,0 coordinatespace*/
        }
        return (lineRect,frameRect)
    }
}

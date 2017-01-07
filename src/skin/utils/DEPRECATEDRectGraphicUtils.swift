import Foundation

class DEPRECATEDRectGraphicUtils {
    /**
     *
     */
    static func maskRect(var rect:CGRect,_ lineStyle:ILineStyle, _ offsetType:OffsetType)->CGRect {
        if(offsetType.left == OffsetType.outside) { rect.width += lineStyle.thickness }
        if(offsetType.right == OffsetType.outside) {rect.width += lineStyle.thickness}
        if(offsetType.top == OffsetType.outside) {rect.height += lineStyle.thickness}
        if(offsetType.bottom == OffsetType.outside) {rect.height += lineStyle.thickness}
        return rect;
    }
    /**
     * Returns a Rect by offsetting PARAM: primitiveRect PARAM: primitiveRect with PARAM: lineOffset
     */
    static func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->CGRect {
        let topLeft:CGPoint = Utils.corner(rect, lineStyle, Alignment.topLeft,offsetType);//cornerPoint(rect, Alignment.TOP_LEFT, offsetType.left, offsetType.top, lineStyle);
        //print("topLeft: " + String(topLeft));
        let bottomRight:CGPoint = Utils.corner(rect, lineStyle, Alignment.bottomRight,offsetType);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        //print("bottomRight: " + String(bottomRight));
        let x:CGFloat = topLeft.x;
        let y:CGFloat = topLeft.y;
        let width:CGFloat = bottomRight.x - topLeft.x;
        let height:CGFloat = bottomRight.y - topLeft.y;
        return CGRect(x, y, width, height);
    }
}
private class Utils{
    /**
     * Returns a corner point
     * // :TODO: refactor
     */
    static func corner(rect:CGRect,_ lineStyle:ILineStyle,_ cornerType:String,_ offsetType:OffsetType)->CGPoint{
        var rectangle:CGRect = rect.clone()
        rectangle.x = lineStyle.thickness/2;
        rectangle.y = lineStyle.thickness/2;
        if(offsetType.right == OffsetType.outside) { rectangle.width = rectangle.width + lineStyle.thickness }
        else if(offsetType.left == OffsetType.outside) { rectangle.width = rectangle.width + lineStyle.thickness }
        if(offsetType.bottom == OffsetType.outside) { rectangle.height += lineStyle.thickness }
        if(offsetType.left == OffsetType.inside) { rectangle.x = -lineStyle.thickness/2 }
        if((offsetType.right == OffsetType.inside) && (offsetType.left == OffsetType.inside)) { rectangle.width = rectangle.width + lineStyle.thickness }
        if(offsetType.top == OffsetType.inside) { rectangle.y = -lineStyle.thickness/2 }
        if(offsetType.bottom == OffsetType.inside) { rectangle.height = rectangle.height + lineStyle.thickness }
        //temp fix, needs more research
        if(offsetType.left == OffsetType.center){rectangle.x = 0;rectangle.y = 0;}
        //temp fix, needs more researchcg
        return rectangle[cornerType];
    }
}
import Foundation

class RectGraphicUtils {
    /**
    * Returns a Rect by offsetting @param primitiveRect @param primitiveRect with @param lineOffset
    */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->CGRect {
        
        let topLeft:CGPoint = Utils.corner(rect, lineStyle, Alignment.topLeft,offsetType);//cornerPoint(rect, Alignment.TOP_LEFT, offsetType.left, offsetType.top, lineStyle);
        /*
        //			print("topLeft: " + topLeft);
        var bottomRight:Point = corner(rect, lineStyle, Alignment.BOTTOM_RIGHT,offsetType);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        //			trace("bottomRight: " + bottomRight);
        var x:Number = topLeft.x;
        var y:Number = topLeft.y;
        var width:Number = bottomRight.x - topLeft.x;
        var height:Number = bottomRight.y - topLeft.y;
        return new Rectangle(x, y, width, height);
        */
        return CGRect()
    }
    
}
private class Utils{
    /**
    * Returns a corner point
    * // :TODO: refactor
    */
    class func corner(rect:CGRect,_ lineStyle:ILineStyle,_ cornerType:String,_ offsetType:OffsetType)->CGPoint{
        var rectangle:CGRect = rect.clone()
        rectangle.x = lineStyle.thickness/2;
        rectangle.y = lineStyle.thickness/2;
        if(offsetType.right == OffsetType.outside) { rectangle.width = rectangle.width + lineStyle.thickness }
        else if(offsetType.left == OffsetType.outside) { rectangle.width = rectangle.width + lineStyle.thickness }
        if(offsetType.bottom == OffsetType.outside) { rectangle.height += lineStyle.thickness }
        if(offsetType.left == OffsetType.inside) { rectangle.x = -lineStyle.thickness/2 }
        if(offsetType.right == OffsetType.inside && offsetType.left == OffsetType.INSIDE) rectangle.width = rectangle.width + lineStyle.thickness;
        /*
        
        
        
        if(offsetType.top == OffsetType.INSIDE) rectangle.y = -lineStyle.thickness/2;
        if(offsetType.bottom == OffsetType.INSIDE) rectangle.height = rectangle.height + lineStyle.thickness;
        return rectangle[cornerType];
        */
        return CGPoint()
    }
}
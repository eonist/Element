import Foundation

class SkinParser {
    /**
     * Returns the position when margin and padding is taken into account
     */
    class func relativePosition(skin:Skin)->CGPoint {
        var margin:Margin = margin(skin);
        var border:Border = border(skin);
        var padding:Padding = padding(skin);
        var offset:Point = offset(skin);
        //Swift.print("padding.left: " + padding.left);
        //Swift.print("margin.left: " + margin.left);
        //Swift.print("skin.x: " + skin.x);
        return CGPoint(/*(skin.element as DisplayObject).x*/ margin.left + border.left + padding.left + offset.x, /*(skin.element as DisplayObject).y*/ margin.top + border.top + padding.top + offset.y);
    }
    /**
     *
     */
    class func margin(skin:ISkin)->Margin{// :TODO: possibly rename to relativeMargin
        return StylePropertyParser.margin(skin);
    }
    /**
    *
    */
    class func border(skin:ISkin)->Border {
        var lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin);
        var lineThickness:CGFloat = StylePropertyParser.value(skin, "line-thickness");
        return Border([lineOffsetType.top == OffsetType.OUTSIDE ? lineThickness : 0, lineOffsetType.right == OffsetType.OUTSIDE ? lineThickness : 0,lineOffsetType.bottom == OffsetType.OUTSIDE ? lineThickness : 0,lineOffsetType.left == OffsetType.OUTSIDE ? lineThickness : 0]);
    }
}

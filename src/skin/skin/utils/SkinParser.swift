import Foundation

class SkinParser {
    /**
     *
     */
    class func totalWidth(skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin);
        let border:Border = self.border(skin);
        let padding:Padding = self.padding(skin);
        return margin.left + border.left + padding.left + width(skin) + padding.right + border.right +  margin.right;
    }
    /**
     *
     */
    class func totalHeight(skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin);
        let border:Border = self.border(skin);
        let padding:Padding = self.padding(skin);
        return margin.top + border.top + padding.top + height(skin) + padding.bottom + border.bottom + margin.bottom;
    }
    /*
     * TODO: I think this is the same as totalHeight now, so remove it, its not. see the height variable
     */
    class func totalHeight2(skin:ISkin)->CGFloat {/*beta*/
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        let height:CGFloat = StylePropertyParser.height(skin)!
        return margin.top + border.top + padding.top + height + padding.bottom + border.bottom + margin.bottom
    }
    /**
     *
     */
    class func width(skin:ISkin)->CGFloat {
        //Swift.print("skin.element!.getWidth(): " + "\(skin.element!.getWidth())")
        //Swift.print("skin.getWidth(): " + "\(skin.getWidth())")
        return !skin.element!.getWidth().isNaN ? skin.element!.getWidth() : skin.getWidth()
    }
    /**
     *
     */
    class func height(skin:ISkin)->CGFloat {
        return !skin.element!.getHeight().isNaN ? skin.element!.getHeight() : skin.getHeight()
    }
    /**
     * Returns the position when margin and padding is taken into account
     */
    class func relativePosition(skin:ISkin/*<--recently hanged from Skin to ISKin*/)->CGPoint {
        let margin:Margin = self.margin(skin);
        let border:Border = self.border(skin);
        let padding:Padding = self.padding(skin);
        let offset:CGPoint = self.offset(skin);
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
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin);
        let value:Any? = StylePropertyParser.value(skin, "line-thickness")
        //Swift.print("SkinParser.border.value: " + "\(value)")
        let lineThickness:CGFloat =  value != nil ? value as! CGFloat : 0
        return Border([lineOffsetType.top == OffsetType.outside ? lineThickness : 0, lineOffsetType.right == OffsetType.outside ? lineThickness : 0,lineOffsetType.bottom == OffsetType.outside ? lineThickness : 0,lineOffsetType.left == OffsetType.outside ? lineThickness : 0]);
    }
    /**
     *
     */
    class func padding(skin:ISkin)->Padding{// :TODO: possibly rename to relativePadding
        return StylePropertyParser.padding(skin)
    }
    /**
     *
     */
    class func offset(skin:ISkin)->CGPoint{// :TODO: possibly rename to relativeOffset
        return StylePropertyParser.offset(skin);
    }
    /**
     *
     */
    class func float(skin:ISkin,_ depth:Int = 0)->String?{
        return StylePropertyParser.value(skin,CSSConstants.float,depth) as? String
    }
    /**
     *
     */
    class func clear(skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.clear) as? String
    }
    /**
     *
     */
    class func display(skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.display) as? String
    }
}
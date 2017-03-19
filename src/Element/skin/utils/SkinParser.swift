import Foundation
@testable import Utils

class SkinParser {
    static func totalWidth(_ skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        return margin.left + border.left + padding.left + width(skin) + padding.right + border.right +  margin.right
    }
    static func totalHeight(_ skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        return margin.top + border.top + padding.top + height(skin) + padding.bottom + border.bottom + margin.bottom
    }
    /*
     * TODO: I think this is the same as totalHeight now, so remove it, its not. see the height variable
     */
    static func totalHeight2(_ skin:ISkin)->CGFloat {/*beta*/
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        let height:CGFloat = StylePropertyParser.height(skin)!
        return margin.top + border.top + padding.top + height + padding.bottom + border.bottom + margin.bottom
    }
    /**
     *
     */
    static func width(_ skin:ISkin)->CGFloat {
        //Swift.print("skin.element!.getWidth(): " + "\(skin.element!.getWidth())")
        //Swift.print("skin.getWidth(): " + "\(skin.getWidth())")
        return !skin.element!.getWidth().isNaN ? skin.element!.getWidth() : skin.getWidth()
    }
    /**
     *
     */
    static func height(_ skin:ISkin)->CGFloat {
        return !skin.element!.getHeight().isNaN ? skin.element!.getHeight() : skin.getHeight()
    }
    /**
     * Returns the position when margin and padding is taken into account
     */
    static func relativePosition(_ skin:ISkin/*<--recently hanged from Skin to ISKin*/)->CGPoint {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        let offset:CGPoint = self.offset(skin)
        //Swift.print("padding.left: " + padding.left)
        //Swift.print("margin.left: " + margin.left)
        //Swift.print("skin.x: " + skin.x)
        return CGPoint(/*(skin.element as DisplayObject).x*/ margin.left + border.left + padding.left + offset.x, /*(skin.element as DisplayObject).y*/ margin.top + border.top + padding.top + offset.y)
    }
    /**
     *
     */
    static func margin(_ skin:ISkin)->Margin{// :TODO: possibly rename to relativeMargin
        return StylePropertyParser.margin(skin)
    }
    /**
     *
     */
    static func border(_ skin:ISkin)->Border {
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin);
        let value:Any? = StylePropertyParser.value(skin, "line-thickness")
        //Swift.print("SkinParser.border.value: " + "\(value)")
        let lineThickness:CGFloat =  value != nil ? value as! CGFloat : 0
        return Border([lineOffsetType.top == OffsetType.outside ? lineThickness : 0, lineOffsetType.right == OffsetType.outside ? lineThickness : 0,lineOffsetType.bottom == OffsetType.outside ? lineThickness : 0,lineOffsetType.left == OffsetType.outside ? lineThickness : 0])
    }
    /**
     *
     */
    static func padding(_ skin:ISkin)->Padding{// :TODO: possibly rename to relativePadding
        return StylePropertyParser.padding(skin)
    }
    /**
     *
     */
    static func offset(_ skin:ISkin)->CGPoint{// :TODO: possibly rename to relativeOffset
        return StylePropertyParser.offset(skin)
    }
    /**
     *
     */
    static func float(_ skin:ISkin,_ depth:Int = 0)->String?{
        return StylePropertyParser.value(skin,CSSConstants.float,depth) as? String
    }
    /**
     *
     */
    static func clear(_ skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.clear) as? String
    }
    /**
     *
     */
    static func display(_ skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.display) as? String
    }
}

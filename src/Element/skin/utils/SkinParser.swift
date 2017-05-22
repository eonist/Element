import Foundation
@testable import Utils

class SkinParser {
    static func totalWidth(_ skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        return width(skin) + margin.hor + border.hor// + padding.hor
    }
    static func totalHeight(_ skin:ISkin)->CGFloat {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        return margin.top + border.top + padding.top + height(skin) + padding.bottom + border.bottom + margin.bottom
     }
    /**
     * Returns width
     */
    static func width(_ skin:ISkin)->CGFloat {
        return !skin.element!.getWidth().isNaN ? skin.element!.getWidth() : skin.getWidth()
    }
    /**
     * Returns height
     */
    static func height(_ skin:ISkin)->CGFloat {
        return !skin.element!.getHeight().isNaN ? skin.element!.getHeight() : skin.getHeight()
    }
    /**
     * Returns the position when margin and padding is taken into account
     */
    static func relativePosition(_ skin:ISkin)->CGPoint {
        let margin:Margin = self.margin(skin)
        let border:Border = self.border(skin)
        let padding:Padding = self.padding(skin)
        let offset:CGPoint = self.offset(skin)
        return CGPoint(/*(skin.element as NSView).x*/ margin.left + border.left + padding.left + offset.x, /*(skin.element as NSView).y*/ margin.top + border.top + padding.top + offset.y)
    }
    /**
     * Returns margin
     */
    static func margin(_ skin:ISkin)->Margin{// :TODO: ⚠️️ possibly rename to relativeMargin
        return StylePropertyParser.margin(skin)
    }
    /**
     * Returns border
     */
    static func border(_ skin:ISkin)->Border {
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin);
        let value:Any? = StylePropertyParser.value(skin, "line-thickness")
        let lineThickness:CGFloat =  value != nil ? value as! CGFloat : 0
        return Border([lineOffsetType.top == OffsetType.outside ? lineThickness : 0, lineOffsetType.right == OffsetType.outside ? lineThickness : 0,lineOffsetType.bottom == OffsetType.outside ? lineThickness : 0,lineOffsetType.left == OffsetType.outside ? lineThickness : 0])
    }
    static func padding(_ skin:ISkin)->Padding{// :TODO: possibly rename to relativePadding
        return StylePropertyParser.padding(skin)
    }
    static func offset(_ skin:ISkin)->CGPoint{// :TODO: possibly rename to relativeOffset
        return StylePropertyParser.offset(skin)
    }
    static func float(_ skin:ISkin,_ depth:Int = 0)->String?{
        return StylePropertyParser.value(skin,CSSConstants.float.rawValue,depth) as? String
    }
    static func clear(_ skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.clear.rawValue) as? String
    }
    static func display(_ skin:ISkin)->String? {
        return StylePropertyParser.value(skin,CSSConstants.display.rawValue) as? String
    }
}

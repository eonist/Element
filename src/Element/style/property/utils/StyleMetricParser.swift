import Foundation

class StyleMetricParser {
    /**
     * Returns Offset
     * TODO: ⚠️️ Merge ver/hor Offset into this one like you did with cornerRadius
     * TODO: ⚠️️ Add support for % as it isnt implemented yet, see the margin implementation for guidance
     */
    static func offset(_ skin:ISkin,_ depth:Int = 0)->CGPoint {
        guard let value:Any = self.value(skin, CSSConstants.offset.rawValue, depth) else{
            return CGPoint(0,0)//<---temp solution
        }
        let array:[CGFloat] = {
            if let value = value as? CGFloat {
                return [value]
            };return (value as! [Any]).cast()
        }()
        return array.count == 1 ? CGPoint(array[0],0) : CGPoint(array[0], array[1])
    }
    /**
     * NOTE: TRBL
     * NOTE: if this method is buggy refer to the legacy code as you changed a couple of method calls : value is now metric
     * TODO: ⚠️️ Should this have a failsafe if there is no Padding property in the style?
     * TODO: ⚠️️ Try to figure out a way to do the padding-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     * TODO: ⚠️️ You may want to copy margin on this
     */
    static func padding(_ skin:ISkin,_ depth:Int = 0) -> Padding {
        var padding:Padding = {
            guard let value = self.value(skin, CSSConstants.padding.rawValue,depth) else{
                return Padding()
            };return Padding(value)
        }()
        let paddingIndex:Int = StyleParser.index(skin.style!, CSSConstants.padding.rawValue, depth)
        padding.left = (StyleParser.index(skin.style!, CSSConstants.paddingLeft.rawValue,depth) > paddingIndex ? StylePropertyParser.metric(skin, CSSConstants.paddingLeft.rawValue, depth) : Utils.metric(padding.left, skin))!/*if margin-left has a later index than margin then it overrides margin.left*/
        padding.right = (StyleParser.index(skin.style!, CSSConstants.paddingRight.rawValue,depth) > paddingIndex ? StylePropertyParser.metric(skin, CSSConstants.paddingRight.rawValue, depth) : Utils.metric(padding.right, skin))!
        padding.top = (StyleParser.index(skin.style!, CSSConstants.paddingTop.rawValue,depth) > paddingIndex ? StylePropertyParser.metric(skin, CSSConstants.paddingTop.rawValue, depth) : Utils.metric(padding.top, skin))!
        padding.bottom = ((StyleParser.index(skin.style!, CSSConstants.paddingBottom.rawValue,depth) > paddingIndex) ? StylePropertyParser.metric(skin, CSSConstants.paddingBottom.rawValue, depth) : Utils.metric(padding.bottom, skin))!
        return padding
    }
    /**
     * TODO: Should this have a failsafe if there is no Margin property in the style?
     * TODO: Try to figure out a way to do the margin-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     */
    static func margin(_ skin:ISkin, _ depth:Int = 0)->Margin {
        var margin:Margin = {
            guard let value = self.value(skin, CSSConstants.margin.rawValue,depth) else{
                return Margin()
            };return Margin(value)
        }()
        let marginIndex:Int = StyleParser.index(skin.style!, CSSConstants.margin.rawValue,depth)
        margin.left = (StyleParser.index(skin.style!, CSSConstants.marginLeft.rawValue,depth) > marginIndex ? metric(skin, CSSConstants.marginLeft.rawValue,depth) : Utils.metric(margin.left, skin))!/*if margin-left has a later index than margin then it overrides margin.left*/
        margin.right = (StyleParser.index(skin.style!, CSSConstants.marginRight.rawValue,depth) > marginIndex ? metric(skin, CSSConstants.marginRight.rawValue,depth) : Utils.metric(margin.right, skin))!
        margin.top = (StyleParser.index(skin.style!, CSSConstants.marginTop.rawValue,depth) > marginIndex ? metric(skin, CSSConstants.marginTop.rawValue,depth) : Utils.metric(margin.top, skin))!
        margin.bottom = StyleParser.index(skin.style!, CSSConstants.marginBottom.rawValue,depth) > marginIndex ? metric(skin, CSSConstants.marginBottom.rawValue,depth)! : Utils.metric(margin.bottom, skin)!
        return margin
    }
    static func width(_ skin:ISkin, _ depth:Int = 0) -> CGFloat? {
        return metric(skin,CSSConstants.width.rawValue,depth)
    }
    static func height(_ skin:ISkin, _ depth:Int = 0) -> CGFloat? {
        return metric(skin,CSSConstants.height.rawValue,depth)
    }
    /**
     * New
     */
    static func rotation(_ skin:ISkin, _ depth:Int = 0) -> CGFloat?{
        return value(skin, CSSConstants.transform.rawValue, depth) as? CGFloat
    }
    /**
     * Returns a Number derived from eigther a percentage value or ems value (20% or 1.125 ems == 18)
     */
    static func metric(_ skin:ISkin,_ propertyName:String, _ depth:Int = 0)->CGFloat? {
        let value = StylePropertyParser.value(skin,propertyName,depth)
        return Utils.metric(value,skin)
    }
}

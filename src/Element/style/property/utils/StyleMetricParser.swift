import Cocoa
@testable import Utils

class StyleMetricParser {
    /**
     * Returns Offset
     * TODO: ⚠️️ Merge ver/hor Offset into this one like you did with cornerRadius
     * TODO: ⚠️️ Add support for % as it isn't implemented yet, see the margin implementation for guidance
     */
    static func offset(_ skin:ISkin,_ depth:Int = 0)->CGPoint {
        guard let value:Any = StylePropertyParser.value(skin, CSSConstants.offset.rawValue, depth) else{
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
            guard let value = StylePropertyParser.value(skin, CSSConstants.padding.rawValue,depth) else{
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
}

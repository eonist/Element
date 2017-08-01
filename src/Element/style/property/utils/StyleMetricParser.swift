import Cocoa
@testable import Utils

class StyleMetricParser {
    /**
     * Returns Offset
     * TODO: ⚠️️ Merge ver/hor Offset into this one like you did with cornerRadius
     * TODO: ⚠️️ Add support for % as it isn't implemented yet, see the margin implementation for guidance
     */
    static func offset(_ skin:ISkin,_ depth:Int = 0)->CGPoint {
        guard let value:Any = StylePropertyParser.value(skin, CSS.Other.offset, depth) else{
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
     * NOTE: If this method is buggy refer to the legacy code as you changed a couple of method calls : value is now metric
     * TODO: ⚠️️ Should this have a failsafe if there is no Padding property in the style?
     * TODO: ⚠️️ Try to figure out a way to do the padding-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     * TODO: ⚠️️ You may want to copy margin on this
     */
    static func padding(_ skin:ISkin,_ depth:Int = 0) -> Padding {
        var padding:Padding = {
            guard let value = StylePropertyParser.value(skin, CSS.Padding.padding,depth) else{
                return Padding()
            };return Padding(value)
        }()
        let paddingIndex:Int = StyleParser.index(skin.style!, CSS.Padding.padding, depth)
        padding.left = (StyleParser.index(skin.style!, CSS.Padding.left,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSS.Padding.left, depth,.hor) : Utils.metric(padding.left, skin, .hor))!/*if margin-left has a later index than margin then it overrides margin.left*/
        padding.right = (StyleParser.index(skin.style!, CSS.Padding.right,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSS.Padding.right, depth,.hor) : Utils.metric(padding.right, skin, .hor))!
        padding.top = (StyleParser.index(skin.style!, CSS.Padding.top,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSS.Padding.top, depth,.ver) : Utils.metric(padding.top, skin,.ver))!
        padding.bottom = ((StyleParser.index(skin.style!, CSS.Padding.bottom,depth) > paddingIndex) ? StyleMetricParser.metric(skin, CSS.Padding.bottom, depth,.ver) : Utils.metric(padding.bottom, skin,.ver))!
        return padding
    }
    /**
     * TODO: Should this have a failsafe if there is no Margin property in the style?
     * TODO: Try to figure out a way to do the margin-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     */
    static func margin(_ skin:ISkin, _ depth:Int = 0)->Margin {
        var margin:Margin = {
            guard let value = StylePropertyParser.value(skin, CSS.Margin.margin,depth) else{
                return Margin()
            };return Margin(value)
        }()
        let marginIndex:Int = StyleParser.index(skin.style!, CSS.Margin.margin,depth)
        margin.left = (StyleParser.index(skin.style!, CSS.Margin.left,depth) > marginIndex ? metric(skin, CSS.Margin.left,depth,.hor) : Utils.metric(margin.left, skin, .hor))!/*if margin-left has a later index than margin then it overrides margin.left*/
        margin.right = (StyleParser.index(skin.style!, CSS.Margin.right,depth) > marginIndex ? metric(skin, CSS.Margin.right,depth,.hor) : Utils.metric(margin.right, skin, .hor))!
        margin.top = (StyleParser.index(skin.style!, CSS.Margin.top,depth) > marginIndex ? metric(skin, CSS.Margin.top,depth,.ver) : Utils.metric(margin.top, skin, .ver))!
        margin.bottom = StyleParser.index(skin.style!, CSS.Margin.bottom,depth) > marginIndex ? metric(skin, CSS.Margin.bottom,depth,.ver)! : Utils.metric(margin.bottom, skin, .ver)!
        return margin
    }
    /**
     * Returns a Number derived from eigther a fixed value, a percentage value or ems value (20% or 1.125 ems == 18)
     * PARAM: dir is to get the correct totW or totH
     */
    static func metric(_ skin:ISkin,_ propertyName:String, _ depth:Int = 0, _ dir:Dir)->CGFloat? {
        let value = StylePropertyParser.value(skin,propertyName,depth)
        return Utils.metric(value,skin,dir)
    }
    /**
     * Returns width (clips to min max height)
     */
    static func width(_ skin:ISkin, _ depth:Int = 0) -> CGFloat? {
        guard let width:CGFloat = metric(skin,CSS.Size.width,depth,.hor) else{
            return nil
        }
        let minWidth:CGFloat = Utils.minWidth(skin) ?? width
        let maxWidth:CGFloat = Utils.maxWidth(skin) ?? width
        return width.clip(minWidth,maxWidth)
    }
    /**
     * Returns height (clips to min max height)
     */
    static func height(_ skin:ISkin, _ depth:Int = 0) -> CGFloat? {
        guard let height:CGFloat = metric(skin,CSS.Size.height,depth,.ver) else{
            return nil
        }
        let minHeight:CGFloat = Utils.minHeight(skin) ?? height
        let maxHeight:CGFloat = Utils.maxHeight(skin) ?? height
        return height.clip(minHeight,maxHeight)
    }
    static func rotation(_ skin:ISkin, _ depth:Int = 0) -> CGFloat?{
        return StylePropertyParser.value(skin, CSS.Other.transform, depth) as? CGFloat
    }
    /**
     * Returns a Fillet instance
     * TODO: ⚠️️ Probably upgrade to TRBL
     * TODO: ⚠️️ Needs to return nil aswell. Since we need to test if a fillet doesnt exist. if a fillet has just 0 values it should still be a fillet etc.
     */
    static func fillet(_ skin:ISkin, _ depth:Int = 0) -> Fillet {
        let val:Any? = StylePropertyParser.value(skin, CSS.CornerRadius.cornerRadius,depth)
        let fillet:Fillet = {
            if (val is CGFloat) || (val is [Any]) {
                return LayoutUtils.instance(val!, Fillet.self) as! Fillet
            };return Fillet()
        }()
        let cornerRadiusIndex:Int = StyleParser.index(skin.style!, CSS.CornerRadius.cornerRadius, depth);//returns -1 if it doesnt exist
        if(StyleParser.index(skin.style!, CSS.CornerRadius.topLeft, depth) > cornerRadiusIndex) { fillet.topLeft = StylePropertyParser.number(skin, CSS.CornerRadius.topLeft, depth) }//TODO: replace this with the constant: cornerRadiusIndex
        if(StyleParser.index(skin.style!, CSS.CornerRadius.topRight, depth) > cornerRadiusIndex) { fillet.topRight = StylePropertyParser.number(skin, CSS.CornerRadius.topRight, depth) }
        if(StyleParser.index(skin.style!, CSS.CornerRadius.bottomLeft, depth) > cornerRadiusIndex) { fillet.bottomLeft = StylePropertyParser.number(skin, CSS.CornerRadius.bottomLeft, depth) }
        if(StyleParser.index(skin.style!, CSS.CornerRadius.bottomRight, depth) > cornerRadiusIndex) { fillet.bottomRight = StylePropertyParser.number(skin, CSS.CornerRadius.bottomRight, depth) }
        return fillet
    }
}
private class Utils{
    private static var metricPattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
    /**
     * Returns size amount, sometimes based on parents size, sometimes on ems, sometimes on the value it has it self
     */
    static func metric(_ value:Any?, _ skin:ISkin, _ dir:Dir)->CGFloat? {
        switch value{
            case is Int:/*<-- int really? shouldn't you use something with decimals?*/
                return CGFloat(value as! Int)
            case is CGFloat:
                return value as? CGFloat
            case is String:/*value is String*/
                let stringValue:String = value as! String
                if StringAsserter.metric(stringValue){
                    return stringMetric(stringValue,skin,dir)
                }else{//calc
                    return calcMetric(stringValue,skin,dir)
                }
            default:
                break;
        }
        return nil//<---this should be 0, it will require some reprograming
    }
    /**
     * New
     * Example: "100% -20px 20px"
     * IMPORTANT: ⚠️️ Using + or space infront of min sign wont work
     * NOTE: not for advance interactive UI adjustments, use setSize in these cases!
     * NOTE: you can also do padding:calc(50%-20px) and you have effectivly centered something
     * NOTE: Does not support * or / chars yet
     */
    private static func calcMetric(_ stringValue:String,_ skin:ISkin, _ dir:Dir) -> CGFloat?{
        let components:[String] = stringValue.split(" ")
        return components.reduce(0){/*sum the amounts*/
            if StringAsserter.metric($1) {
                //Swift.print("isMetric")
                return $0! + stringMetric($1,skin,dir)!
            }else if StringAsserter.digit($1){
                //Swift.print("isDigit")
                return $0! + StringParser.digit($1)
            }else{fatalError("type not supported: \($1)")}
        }
    }
    /**
     * New
     * Returns a size value based on percentage based on the parent
     * NOTE: In a way this method is recursive, as totW and totH calls the getW and getH again which in turn can call this method again etc
     */
    private static func stringMetric(_ stringValue:String,_ skin:ISkin, _ dir:Dir) -> CGFloat?{
        let matches = stringValue.matches(metricPattern)
        if let match:NSTextCheckingResult = matches.first {
            let valStr:String = match.value(stringValue, 1)/*capturing group 1*/
            let suffix:String = match.value(stringValue, 2)/*capturing group 1*/
            let valNum:CGFloat = valStr.cgFloat
            if(suffix == "%") {
                return {
                    let totWidth:CGFloat = {
                        if let parent:IElement = skin.element?.getParent() as? IElement{
                            return dir == .hor ? totalWidth(parent) : totalHeight(parent)/*totHeight support is new*/
                        };return 0
                    }()
                    return valNum / 100 * totWidth
                    }()
            }else {
                return valNum * CSS.Text.emsFontSize/*["suffix"] == "ems"*/
            }
        }//maybe error here
        return nil
    }
    /**
     * Returns the total width
     * TODO: ⚠️️ Should margin be added to total width? check google for the box model specs (a work around is too add equal amount of margin-right)
     */
    private static func totalWidth(_ element:IElement) -> CGFloat {
        if let skin = element.skin {
            //let margin:Margin = SkinParser.margin(skin)
            let border:Border = SkinParser.border(skin)
            let padding:Padding = SkinParser.padding(skin)
            let width:CGFloat = element.getWidth()
            return /*margin.left +*/ border.left + width - padding.hor - border.right /*- margin.right*/
        };return element.getWidth()
    }
    /**
     * New
     */
    private static func totalHeight(_ element:IElement) -> CGFloat {
        if let skin = element.skin {
            //let margin:Margin = SkinParser.margin(skin)
            let border:Border = SkinParser.border(skin)
            let padding:Padding = SkinParser.padding(skin)
            let height:CGFloat = element.getHeight()
            return /*margin.top +*/ border.top + height - padding.ver - border.bottom /*- margin.bottom*/
        };return element.getHeight()
    }
    /**
     * New
     */
    static func minWidth(_ skin:ISkin, _ depth:Int = 0)->CGFloat?{
        let minWidth:CGFloat? = StyleMetricParser.metric(skin,CSS.Size.minWidth,depth,.hor)
        return minWidth
    }
    /**
     * New
     */
    static func minHeight(_ skin:ISkin, _ depth:Int = 0)->CGFloat?{
        let minHeight:CGFloat? = StyleMetricParser.metric(skin,CSS.Size.minHeight,depth,.hor)
        return minHeight
    }
    /**
     * New
     */
    static func maxWidth(_ skin:ISkin, _ depth:Int = 0)->CGFloat?{
        let maxWidth:CGFloat? = StyleMetricParser.metric(skin,CSS.Size.maxWidth,depth,.hor)
        return maxWidth
    }
    /**
     * New
     */
    static func maxHeight(_ skin:ISkin, _ depth:Int = 0)->CGFloat?{
        let maxHeight:CGFloat? = StyleMetricParser.metric(skin,CSS.Size.maxHeight,depth,.hor)
        return maxHeight
    }
}

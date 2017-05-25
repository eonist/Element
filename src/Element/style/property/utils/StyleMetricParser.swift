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
        padding.left = (StyleParser.index(skin.style!, CSSConstants.paddingLeft.rawValue,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSSConstants.paddingLeft.rawValue, depth) : Utils.metric(padding.left, skin))!/*if margin-left has a later index than margin then it overrides margin.left*/
        padding.right = (StyleParser.index(skin.style!, CSSConstants.paddingRight.rawValue,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSSConstants.paddingRight.rawValue, depth) : Utils.metric(padding.right, skin))!
        padding.top = (StyleParser.index(skin.style!, CSSConstants.paddingTop.rawValue,depth) > paddingIndex ? StyleMetricParser.metric(skin, CSSConstants.paddingTop.rawValue, depth) : Utils.metric(padding.top, skin))!
        padding.bottom = ((StyleParser.index(skin.style!, CSSConstants.paddingBottom.rawValue,depth) > paddingIndex) ? StyleMetricParser.metric(skin, CSSConstants.paddingBottom.rawValue, depth) : Utils.metric(padding.bottom, skin))!
        return padding
    }
    /**
     * TODO: Should this have a failsafe if there is no Margin property in the style?
     * TODO: Try to figure out a way to do the margin-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     */
    static func margin(_ skin:ISkin, _ depth:Int = 0)->Margin {
        var margin:Margin = {
            guard let value = StylePropertyParser.value(skin, CSSConstants.margin.rawValue,depth) else{
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
    /**
     * Returns a Number derived from eigther a percentage value or ems value (20% or 1.125 ems == 18)
     */
    static func metric(_ skin:ISkin,_ propertyName:String, _ depth:Int = 0)->CGFloat? {
        let value = StylePropertyParser.value(skin,propertyName,depth)
        return Utils.metric(value,skin)
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
        return StylePropertyParser.value(skin, CSSConstants.transform.rawValue, depth) as? CGFloat
    }
}
private class Utils{
    private static var metricPattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
    /**
     * TODO: Explain what this method is doing
     * TODO: ⚠️️ Needs some Functional programming 🤖
     */
    static func metric(_ value:Any?,_ skin:ISkin)->CGFloat? {
        if(value is Int){ return CGFloat(value as! Int)}/*<-- int really? shouldnt you use something with decimals?*/
        else if(value is CGFloat){return value as? CGFloat}
        else if(value is String){/*value is String*/
            let stringValue:String = value as! String
            let matches = stringValue.matches(metricPattern)
            for match:NSTextCheckingResult in matches {
                let valStr:String = match.value(stringValue, 1)/*capturing group 1*/
                let suffix:String = match.value(stringValue, 2)/*capturing group 1*/
                let valNum:CGFloat = valStr.cgFloat
                if(suffix == "%") {
                    let val:CGFloat = valNum / 100 * (skin.element!.getParent() != nil ? (totalWidth(skin.element!.getParent() as! IElement)/*(skin.element.parent as IElement).getWidth()*/) : 0);/*we use the width of the parent if the value is percentage, in accordance to how css works*/
                    //Swift.print("skin.element.parent != null: " + skin.element.parent != null)
                    //Swift.print("(skin.element.parent as IElement).skin: " + (skin.element.parent as IElement).skin)
                    return val
                }else {
                    return valNum * CSSConstants.emsFontSize/*["suffix"] == "ems"*/
                }
            }
        }
        //⚠️️ be warned this method is far from complete
        return nil//<---this should be 0, it will require some reprograming
    }
    /**
     * Returns the total width
     * TODO: ⚠️️Should margin be added to total width? check google for the box model specs (a work around is too add equal amount of margin-right)
     */
    static func totalWidth(_ element:IElement)->CGFloat {
        if(element.skin != nil){
            let margin:Margin = SkinParser.margin(element.skin!)
            let border:Border = SkinParser.border(element.skin!)
            let padding:Padding = SkinParser.padding(element.skin!)
            let width:CGFloat = element.getWidth()/*StylePropertyParser.height(element.skin);*/
            let tot:CGFloat = margin.left + border.left + width - padding.left - padding.right - border.right - margin.right
            return tot/*Note used to be + padding.right + border.right + margin.right*/
        }else {return element.getWidth()}
    }
    
}

import Foundation

class StylePropertyParser{
    /**
     * Returns a property from @param skin and @param property
     * @Note the reason that depth defaults to 0 is because if the exact depth isnt found there should only be depth 0, if you have more than 1 depth in a property then you must supply at all depths or just the 1 that will work for all depths
     * // :TODO: should probably also support when state is know and depth is defaulted to 0 ?!?!?
     */
    class func value(skin:ISkin, propertyName:String/*, depth:int = 0*/)->Any?{
        return nil
    }
    class func fillStyle(skin:ISkin):IFillStyle {
        return value(skin,CSSConstants.fill) is IGradient ? gradientFillStyle(skin):colorFillStyle(skin);
    }
    /**
    * Returns a FillStyle instance
    */
    class func colorFillStyle(skin:ISkin)->IFillStyle? {
        var value:* = StylePropertyParser.value(skin, CSSConstants.FILL,depth);
        //print("value: " + value);
        var color:NSColor = value[1] == CSSConstants.NONE ? NaN : StringParser.color(value[1]);
        
        return nil
    }
    /**
    * Returns a GradientFillStyle
    */
    class func gradientFillStyle(skin:ISkin) -> GradientFillStyle? {
        return nil
    }
}
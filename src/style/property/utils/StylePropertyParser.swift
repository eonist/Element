import Cocoa

class StylePropertyParser{
    /**
     * Returns a property from @param skin and @param property
     * @Note the reason that depth defaults to 0 is because if the exact depth isnt found there should only be depth 0, if you have more than 1 depth in a property then you must supply at all depths or just the 1 that will work for all depths
     * // :TODO: should probably also support when state is know and depth is defaulted to 0 ?!?!?
     */
    class func value(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->Any{
        Swift.print("StylePropertyParser.value() propertyName: " + propertyName)
        let value:Any? = skin.style!.getValue(propertyName);
        Swift.print("value: " + "\(value)")
        
        
        //continue here, you need to get width from the element if style doesnt have width
        
        
        return value;
    }
    class func fillStyle(skin:ISkin)->IFillStyle {
        return value(skin,CSSConstants.fill) is IGradient ? gradientFillStyle(skin):colorFillStyle(skin);
    }
    /**
     * Returns a FillStyle instance
     */
    class func colorFillStyle(skin:ISkin)->IFillStyle {
        print("StylePropertyParser.colorFillStyle()")
        let colorValue:Any? = StylePropertyParser.value(skin, CSSConstants.fill);
        print("colorValue: " + "\(colorValue)");
        var color:Double;
        if(colorValue is Array<UInt>) {
            fatalError("NOT IMPLEMENTED YET")
        }else if(colorValue == nil){
            color = Double.NaN
        }else {/*colorValue is UInt*/
            color = Double(colorValue as! UInt);
        }
        let alpha:Any? = StylePropertyParser.value(skin, CSSConstants.fillAlpha)
        print("alpha: " + "\(alpha)")
        let alphaValue:Double = alpha == nil ? Double.NaN : alpha as! Double
        Swift.print("alphaValue: " + "\(alphaValue)")
        let nsColor:NSColor = ColorParser.nsColor(UInt(color), Float(alphaValue))//fill
        //TODO:You need to upgrade FillStyle to support alpha and color and add NSColor further down the line because checking for NaN is essential when setting or not setting things?, you can revert to pure NSColor and clearStyle later anyway
        return FillStyle(nsColor)
    }
    /**
    * Returns a Fillet instance
    * // :TODO: probably upgrade to TRBL
    */
    class func fillet(skin:ISkin) -> Fillet {
        let val = value(skin, CSSConstants.cornerRadius);
        var fillet:Fillet = Fillet();
        if((val is Double) || (val is Array<Double>)) {//(val is String) ||
            fillet = LayoutUtils.instance(val, Fillet.self) as! Fillet
        };
        let cornerRadiusIndex:Int = StyleParser.index(skin.style!, CSSConstants.cornerRadius);//returns -1 if it doesnt exist
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopLeft) > cornerRadiusIndex) { fillet.topLeft = StylePropertyParser.value(skin, "corner-radius-top-left") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopRight) > cornerRadiusIndex) { fillet.topRight = StylePropertyParser.value(skin, "corner-radius-top-right") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomLeft) > cornerRadiusIndex) { fillet.bottomLeft = StylePropertyParser.value(skin, "corner-radius-bottom-left") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomRight) > cornerRadiusIndex) { fillet.bottomRight = StylePropertyParser.value(skin, "corner-radius-bottom-right") }
        return fillet;
    }
    /**
     * Returns a GradientFillStyle
     */
    class func gradientFillStyle(skin:ISkin) -> GradientFillStyle {
        fatalError("NOT IMPLEMENTED YET")
    }
    /**
     *
     */
    class func width(skin:ISkin) -> Double? {
        return metric(skin,CSSConstants.width)
    }
    /**
     *
     */
    class func height(skin:ISkin) -> Double? {
        return metric(skin,CSSConstants.height)
    }
    /**
     * Returns a Number derived from eigther a percentage value or ems value (20% or 1.125 ems == 18)
     */
    class func metric(skin:ISkin,_ propertyName:String)->Double? {
        let value = StylePropertyParser.value(skin,propertyName);
        return Utils.metric(value,skin);
    }
}
private class Utils{
    /**
    * // :TODO: explain what this method is doing
    */
    class func metric(value:Any?,_ skin:ISkin)->Double? {
        if(value is Int){ return Double(value as! Int)
        }else{
            return nil
            //fatalError("NOT IMPLEMENTED YET")
        }
    }
}
extension StylePropertyParser{
    /*
     * Convenince method for deriving Double values
     */
    class func value(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->Double{
        return Double(String(value(skin, propertyName)))!
    }
}
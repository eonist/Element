import Cocoa

class StylePropertyParser{
    /**
     * Returns a property from @param skin and @param property
     * @Note the reason that depth defaults to 0 is because if the exact depth isnt found there should only be depth 0, if you have more than 1 depth in a property then you must supply at all depths or just the 1 that will work for all depths
     * // :TODO: should probably also support when state is know and depth is defaulted to 0 ?!?!?
     */
    class func value(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->Any!{
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
        let colorValue = StylePropertyParser.value(skin, CSSConstants.fill);
        print("colorValue: " + "\(colorValue)");
        var color:UInt;
        if(value is Array<UInt>) {
        
        }else if(value == null) color = NaN;
        
        }
        let alpha = String(StylePropertyParser.value(skin, CSSConstants.fillAlpha))
        print("alpha: " + alpha)
        let alphaValue:Float = Float(Double(alpha)!)
        Swift.print("alphaValue: " + "\(alphaValue)")
        let color:NSColor = colorValue == CSSConstants.none ? NSColor.clearColor() : ColorParser.nsColor(colorValue, alphaValue)//fill
        
        return FillStyle(color)
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
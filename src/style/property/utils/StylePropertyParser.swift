import Cocoa

class StylePropertyParser{
    /**
     * Returns a property from @param skin and @param property
     * @Note the reason that depth defaults to 0 is because if the exact depth isnt found there should only be depth 0, if you have more than 1 depth in a property then you must supply at all depths or just the 1 that will work for all depths
     * // :TODO: should probably also support when state is know and depth is defaulted to 0 ?!?!?
     */
    class func value(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->Any!{//TODO: <- try to remove the ! char here
        //Swift.print("StylePropertyParser.value() propertyName: " + propertyName)
        let value:Any? = skin.style!.getValue(propertyName);
        //Swift.print("value: " + "\(value)")
        
        
        //continue here, you need to get width from the element if style doesnt have width
        
        
        return value;
    }
    class func fillStyle(skin:ISkin)->IFillStyle {
        return value(skin,CSSConstants.fill) is IGradient ? gradientFillStyle(skin):colorFillStyle(skin);
    }
    class func lineStyle(skin:ISkin)->ILineStyle {
        return value(skin,CSSConstants.line) is IGradient ? gradientLineStyle(skin) : colorLineStyle(skin);
    }
    /**
     * Returns a FillStyle instance
     */
    class func colorFillStyle(skin:ISkin)->IFillStyle {
        //print("StylePropertyParser.colorFillStyle()")
        let colorValue:Any? = StylePropertyParser.value(skin, CSSConstants.fill);
        //print("colorValue: " + "\(colorValue)");
        var color:Double;
        if(colorValue is Array<UInt>) {
            fatalError("NOT IMPLEMENTED YET")
        }else if(colorValue == nil){
            color = Double.NaN
        }else {/*colorValue is UInt*/
            color = Double(colorValue as! UInt);
        }
        let alpha:Any? = StylePropertyParser.value(skin, CSSConstants.fillAlpha)
        //print("alpha: " + "\(alpha)")
        let alphaValue:Double = alpha == nil ? Double.NaN : alpha as! Double
        //Swift.print("alphaValue: " + "\(alphaValue)")
        let nsColor:NSColor = ColorParser.nsColor(UInt(color), Float(alphaValue))//fill
        //TODO:You need to upgrade FillStyle to support alpha and color and add NSColor further down the line because checking for NaN is essential when setting or not setting things?, you can revert to pure NSColor and clearStyle later anyway
        return FillStyle(nsColor)
    }
    /**
    * Returns a LineStyle instance
    * // :TODO: this is wrong the style property named line-color doesnt exist anymore, its just line now
    * @Note we use line-thickness because the property thickness is occupid by textfield.thickness
    */
    class func colorLineStyle(skin:ISkin) -> ILineStyle {
        let lineThickness:CGFloat = CGFloat(value(skin, CSSConstants.lineThickness) as! Double)
        let lineColorValue:Double = color(skin, CSSConstants.line)
        let lineAlpha:Double = value(skin, CSSConstants.lineAlpha) as? Double ?? Double.NaN
        let lineColor:NSColor = ColorParser.nsColor(UInt(lineColorValue), Float(lineAlpha))
        return LineStyle(lineThickness, lineColor);
    }
    /**
     * @Note makes sure that if the value is set to "none" or doesnt exsist then NaN is returned (NaN is interpreted as do not draw or apply style)
     */
    class func color(skin:ISkin, _ propertyName:String) -> Double {
        let color:Any? = value(skin, propertyName);
        return (String(color) == CSSConstants.none || color == nil) ? Double.NaN : Double(color as! UInt);
    }
    /**
     * Returns an Offset instance
     * // :TODO: probably upgrade to TRBL
     */
    class func lineOffsetType(skin:ISkin) -> OffsetType {
        let val:Any? = value(skin, CSSConstants.lineOffsetType);
        var offsetType:OffsetType = OffsetType();
        if((val is Double) || (val is Array<Double>)) {/*(val is String) || */
            
            offsetType = LayoutUtils.instance(val, OffsetType.self)
            
        }
        let lineOffsetTypeIndex:Int = StyleParser.index(skin.style!, CSSConstants.lineOffsetType);
        if(StyleParser.index(skin.style, CSSConstants.lineOffsetTypeLeft) > lineOffsetTypeIndex) offsetType.left = StylePropertyParser.value(skin, "line-offset-type-left", depth);
        if(StyleParser.index(skin.style, CSSConstants.lineOffsetTypeRight) > lineOffsetTypeIndex) offsetType.right = StylePropertyParser.value(skin, "line-offset-type-right", depth);
        if(StyleParser.index(skin.style, CSSConstants.lineOffsetTypeTop) > lineOffsetTypeIndex) offsetType.top = StylePropertyParser.value(skin, "line-offset-type-top", depth);
        if(StyleParser.index(skin.style, CSSConstants.lineOffsetTypeBottom) > lineOffsetTypeIndex) offsetType.bottom = StylePropertyParser.value(skin, "line-offset-type-bottom", depth);
        return offsetType;
    }
    /**
     * Returns a Fillet instance
     * // :TODO: probably upgrade to TRBL
     */
    class func fillet(skin:ISkin) -> Fillet {
        let val:Any? = value(skin, CSSConstants.cornerRadius);
        var fillet:Fillet = Fillet();
        if((val is Double) || (val is Array<Double>)) {//(val is String) ||
            fillet = LayoutUtils.instance(val!, Fillet.self) as! Fillet
        }
        let cornerRadiusIndex:Int = StyleParser.index(skin.style!, CSSConstants.cornerRadius);//returns -1 if it doesnt exist
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopLeft) > cornerRadiusIndex) { fillet.topLeft = StylePropertyParser.double(skin, "corner-radius-top-left") }//TODO: replace this with the constant: cornerRadiusIndex
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopRight) > cornerRadiusIndex) { fillet.topRight = StylePropertyParser.double(skin, "corner-radius-top-right") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomLeft) > cornerRadiusIndex) { fillet.bottomLeft = StylePropertyParser.double(skin, "corner-radius-bottom-left") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomRight) > cornerRadiusIndex) { fillet.bottomRight = StylePropertyParser.double(skin, "corner-radius-bottom-right") }
        return fillet;
    }
    /**
     * Returns a GradientFillStyle
     */
    class func gradientFillStyle(skin:ISkin) -> GradientFillStyle {
        let newGradient:IGradient = value(skin, "fill") as! IGradient//GradientParser.clone();
        //let sizeWidth:Double = skin.width!
        //let sizeHeight:Double = skin.height!
        return GradientFillStyle(newGradient,NSColor.clearColor());
    }
    /**
    * Returns a GradientLineStyle
    * // :TODO: does this work? where is the creation of line-thickness etc
    * @Note we use line-thickness because the property thickness is occupid by textfield.thickness
    */
    class func gradientLineStyle(skin:ISkin) -> GradientLineStyle {
        var gradient:IGradient = value(skin, CSSConstants.line) as! IGradient
        gradient.rotation *= ㎭
        return GradientLineStyle(gradient, colorLineStyle(skin));
    }
    /**
     *
     */
    class func width(skin:ISkin) -> CGFloat? {
        return metric(skin,CSSConstants.width)
    }
    /**
     *
     */
    class func height(skin:ISkin) -> CGFloat? {
        return metric(skin,CSSConstants.height)
    }
    /**
     * Returns a Number derived from eigther a percentage value or ems value (20% or 1.125 ems == 18)
     */
    class func metric(skin:ISkin,_ propertyName:String)->CGFloat? {
        let value = StylePropertyParser.value(skin,propertyName);
        return Utils.metric(value,skin);
    }
}
private class Utils{
    /**
    * // :TODO: explain what this method is doing
    */
    class func metric(value:Any?,_ skin:ISkin)->CGFloat? {
        if(value is Int){ return CGFloat(value as! Int)
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
    class func double(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->Double{
        return Double(String(value(skin, propertyName)))!
    }
}
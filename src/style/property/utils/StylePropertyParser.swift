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
        let alphaValue:CGFloat = alpha as? CGFloat ?? 1
        //Swift.print("alphaValue: " + "\(alphaValue)")
        let nsColor:NSColor = NSColorParser.nsColor(UInt(color), alphaValue)//fill
        //TODO:You need to upgrade FillStyle to support alpha and color and add NSColor further down the line because checking for NaN is essential when setting or not setting things?, you can revert to pure NSColor and clearStyle later anyway
        return FillStyle(nsColor)
    }
    /**
    * Returns a LineStyle instance
    * // :TODO: this is wrong the style property named line-color doesnt exist anymore, its just line now
    * @Note we use line-thickness because the property thickness is occupid by textfield.thickness
    */
    class func colorLineStyle(skin:ISkin) -> ILineStyle {
        //Swift.print("StylePropertyParser.colorLineStyle()")
        let lineThickness:CGFloat = value(skin, CSSConstants.lineThickness) as? CGFloat ?? CGFloat.NaN
        let lineColorValue:Double = color(skin, CSSConstants.line)
        //Swift.print("StylePropertyParser.colorLineStyle() " + String(value(skin, CSSConstants.lineAlpha)))
        let lineAlpha:CGFloat = value(skin, CSSConstants.lineAlpha) as? CGFloat ?? 1
        let lineColor:NSColor = nsColor(lineColorValue, lineAlpha)
        return LineStyle(lineThickness, lineColor);
    }
    /**
     * new
     */
    class func nsColor(color:Double,_ alpha:CGFloat)->NSColor{
        let nsColor = color.isNaN ? NSColor.clearColor() : NSColorParser.nsColor(UInt(color), alpha)
        return nsColor
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
        //Swift.print("StylePropertyparser.lineOffsetType()")
        let val:Any? = value(skin, CSSConstants.lineOffsetType);
        var offsetType:OffsetType = OffsetType();
        if((val is String) || (val is Array<String>)) {/*(val is String) || */offsetType = LayoutUtils.instance(val!, OffsetType.self) as! OffsetType}
        let lineOffsetTypeIndex:Int = StyleParser.index(skin.style!, CSSConstants.lineOffsetType);
        if(StyleParser.index(skin.style!, CSSConstants.lineOffsetTypeLeft) > lineOffsetTypeIndex){ offsetType.left = StylePropertyParser.string(skin, "line-offset-type-left")}
        if(StyleParser.index(skin.style!, CSSConstants.lineOffsetTypeRight) > lineOffsetTypeIndex){ offsetType.right = StylePropertyParser.string(skin, "line-offset-type-right")}
        if(StyleParser.index(skin.style!, CSSConstants.lineOffsetTypeTop) > lineOffsetTypeIndex){ offsetType.top = StylePropertyParser.string(skin, "line-offset-type-top")}
        if(StyleParser.index(skin.style!, CSSConstants.lineOffsetTypeBottom) > lineOffsetTypeIndex){ offsetType.bottom = StylePropertyParser.string(skin, "line-offset-type-bottom")}
        return offsetType;
    }
    /**
     * Returns a Fillet instance
     * // :TODO: probably upgrade to TRBL
     */
    class func fillet(skin:ISkin) -> Fillet {
        let val:Any? = value(skin, CSSConstants.cornerRadius);
        var fillet:Fillet = Fillet();
        //Swift.print(val)
        if((val is CGFloat) || (val is Array<Any>)) {/*(val is String) ||*/fillet = LayoutUtils.instance(val!, Fillet.self) as! Fillet}
        
        //Swift.print("StylePropertyParser.fillet: " + String(ClassParser.classType(val!)))
        //Swift.print(fillet.topRight)
        let cornerRadiusIndex:Int = StyleParser.index(skin.style!, CSSConstants.cornerRadius);//returns -1 if it doesnt exist
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopLeft) > cornerRadiusIndex) { fillet.topLeft = StylePropertyParser.number(skin, "corner-radius-top-left") }//TODO: replace this with the constant: cornerRadiusIndex
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusTopRight) > cornerRadiusIndex) { fillet.topRight = StylePropertyParser.number(skin, "corner-radius-top-right") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomLeft) > cornerRadiusIndex) { fillet.bottomLeft = StylePropertyParser.number(skin, "corner-radius-bottom-left") }
        if(StyleParser.index(skin.style!, CSSConstants.cornerRadiusBottomRight) > cornerRadiusIndex) { fillet.bottomRight = StylePropertyParser.number(skin, "corner-radius-bottom-right") }
        return fillet;
    }
    /**
     * Returns a GradientFillStyle
     */
    class func gradientFillStyle(skin:ISkin) -> GradientFillStyle {
        let newGradient:Gradient/*IGradient*/ = value(skin, "fill") as! Gradient/*IGradient*///GradientParser.clone();
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
        let lineThickness:CGFloat = value(skin, CSSConstants.lineThickness) as! CGFloat
        return GradientLineStyle(gradient, lineThickness, NSColor.clearColor()/*colorLineStyle(skin)*/);
    }
    /**
     *
     */
    class func textFormat(skin:TextSkin)->TextFormat {
        let textFormat:TextFormat = TextFormat();
        for textFormatKey : String in TextFormatConstants.textFormatPropertyNames {
            var value:Any? = StylePropertyParser.value(skin, textFormatKey);
            //Swift.print("StylePropertypParser.textFormat() value: " + "\(value.dynamicType)")
            //				if(textFormatKey == "size") trace("size: "+value+" "+(value is String));
            if(value != nil) {
                if(StringAsserter.metric(String(value))){
                    let pattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
                    let stringValue:String = String(value)
                    let matches = stringValue.matches(pattern)
                    for match:NSTextCheckingResult in matches {
                        var value:Any = (stringValue as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
                        let suffix:String = (stringValue as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 1
                        if(suffix == CSSConstants.ems) {value = CGFloat(Double(String(value))!) * CSSConstants.emsFontSize }
                    }
                }
                if(value is Array<String>) { value = StringModifier.combine(value as! Array<String>, " ") }/*Some fonts are seperated by a space and thus are converted to an array*/
                else if(value is UInt) {
                    
                    value = NSColorParser.nsColor(value as! UInt,1)
                    //Swift.print("FOUND A COLOR: " + textFormatKey + " : " + "\(value)")
                }//<--set the alpha in css aswell backgroundAlpha?
                textFormat[textFormatKey] = value!;
            }
        }
        return textFormat;
    }
    /**
     * @Note this is really a modifier method
     * // :TODO: add support for % (this is the percentage of the inherited font-size value, if none is present i think its 12px)
     */
    class func textField(skin:TextSkin) {
        for textFieldKey : String in TextFieldConstants.textFieldPropertyNames {
            let value:Any? = StylePropertyParser.value(skin,textFieldKey);
            if(value != nil) {
                if(StringAsserter.metric(value as! String)){
                    //TODO:you may need to set one of the inner groups to be non-catachple
                    let pattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
                    let stringValue:String = String(value)
                    let matches = stringValue.matches(pattern)
                    for match:NSTextCheckingResult in matches {
                        var value:Any = (stringValue as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
                        let suffix:String = (stringValue as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 1
                        if(suffix == CSSConstants.ems) {value = CGFloat(Double(String(value))!) * CSSConstants.emsFontSize }
                    }
                }
                //TODO: this needs to be done via subscript probably, see that other code where you used subscripting recently
                fatalError("Not implemented yet")
                //skin.textField[textFieldKey] = value;
            }
        }
    }
    
    
    
    //continue here: impliment this, then continue with the align method and test it with top-margin of the textButton
    
    
    
    
    /**
     * // :TODO: should this have a failsafe if there is no Margin property in the style?
     * // :TODO: try to figure out a way to do the margin-left right top bottom stuff in the css resolvment not here it looks so cognativly taxing
     */
    class func margin(skin:ISkin)->Margin {
        let value:Any? = StylePropertyParser.value(skin, CSSConstants.margin);
        let margin:Margin = value != nil ? Margin(value!) : Margin()
        let marginIndex:Int = StyleParser.index(skin.style!, CSSConstants.margin);
        //Swift.print(StyleParser.index(skin.style!, CSSConstants.marginLeft))
        margin.left = (StyleParser.index(skin.style!, CSSConstants.marginLeft) > marginIndex ? metric(skin, CSSConstants.marginLeft) : Utils.metric(margin.left, skin))!;/*if margin-left has a later index than margin then it overrides margin.left*/
        margin.right = (StyleParser.index(skin.style!, CSSConstants.marginRight) > marginIndex ? metric(skin, CSSConstants.marginRight) : Utils.metric(margin.right, skin))!;
        margin.top = (StyleParser.index(skin.style!, CSSConstants.marginTop) > marginIndex ? metric(skin, CSSConstants.marginTop) : Utils.metric(margin.top, skin))!;
        margin.bottom = StyleParser.index(skin.style!, CSSConstants.marginBottom) > marginIndex ? metric(skin, CSSConstants.marginBottom)! : Utils.metric(margin.bottom, skin)!;
        return margin;
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
    /**
     *
     */
    class func dropShadow(skin:ISkin)->DropShadow? {
        let dropShadow:Any? = value(skin, CSSConstants.drop_shadow);
        return (dropShadow == nil || dropShadow as! String == CSSConstants.none) ? nil : dropShadow as? DropShadow;
    }
}
private class Utils{
    /**
     * // :TODO: explain what this method is doing
     */
    class func metric(value:Any?,_ skin:ISkin)->CGFloat? {
        if(value is Int){ return CGFloat(value as! Int)}
        else if(value is CGFloat){ return value as? CGFloat}
        else{
            //fatalError("NOT IMPLEMENTED YET")
            
            
            //be warned this method is far from complete
            
            
            return nil
            
        }
    }
}
extension StylePropertyParser{
    /*
     * Convenince method for deriving CGFloat values
     */
    class func number(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->CGFloat{
        return CGFloat(Double(string(skin, propertyName))!)
    }
    /*
    * Convenince method for deriving String values
    */
    class func string(skin:ISkin, _ propertyName:String/*, depth:int = 0*/)->String{
        return String(value(skin, propertyName))
    }
}
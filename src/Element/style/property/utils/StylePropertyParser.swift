import Cocoa
@testable import Utils
/**
 * NOTE: We query with skin because we need to access element in the metrics method
 */
class StylePropertyParser{
    /**
     * Returns a property from PARAM: skin and PARAM: property
     * NOTE: the reason that depth defaults to 0 is because if the exact depth isnt found there should only be depth 0, if you have more than 1 depth in a property then you must supply at all depths or just the 1 that will work for all depths
     * TODO: ⚠️️ Should probably also support when state is know and depth is defaulted to 0 ?!?!?
     */
    static func value(_ skin:Skinable, _ propertyName:String, _ depth:Int = 0)->Any!{//TODO: <-- Try to remove the ! char here
        return skin.style!.getValue(propertyName,depth)
    }
    /**
     * Returns an IFillStyle instance based on the Style attached to the skin
     * TODO: ⚠️️ Should return nil as well
     */
    static func fillStyle(_ skin:Skinable,_ depth:Int = 0)->FillStyleKind {
        let val = value(skin,CSS.Other.fill,depth)
        if let gradient = val as? IGradient {
            return gradientFillStyle(gradient)
        }else{//colors
            return colorFillStyle(val,skin,depth)
        }
    }
    /**
     * Returns an ILineStyle instance based on the Style attached to the skin
     */
    static func lineStyle(_ skin:Skinable, _ depth:Int = 0) -> LineStylable? {
        let val:Any? = value(skin,CSS.Other.line,depth)
        if let gradient = val as? IGradient {
            return gradientLineStyle(gradient,skin,depth)
        }else if let color = val as? NSColor{
            return colorLineStyle(color,skin,depth)
        };return nil
    }
    /**
     * Returns an Offset instance
     * TODO: probably upgrade to TRBL
     * NOTE: the way you let the index in the css list decide if something should be included in the final offsetType is probably a bad convention. Im not sure. Just write a note why, if you figure out why its like this.
     */
    static func lineOffsetType(_ skin:Skinable, _ depth:Int = 0) -> OffsetType {
        let val:Any? = value(skin, CSS.LineOffsetType.lineOffsetType,depth)
        var offsetType:OffsetType = {
            if (val is String) || (val is [String]) {
                return LayoutUtils.instance(val!, OffsetType.self) as! OffsetType
            };return OffsetType()
        }()
        let lineOffsetTypeIndex:Int = StyleParser.index(skin.style!, CSS.LineOffsetType.lineOffsetType,depth)
        if(StyleParser.index(skin.style!, CSS.LineOffsetType.left,depth) > lineOffsetTypeIndex){ offsetType.left = StylePropertyParser.string(skin, CSS.LineOffsetType.left)}
        if(StyleParser.index(skin.style!, CSS.LineOffsetType.right,depth) > lineOffsetTypeIndex){ offsetType.right = StylePropertyParser.string(skin, CSS.LineOffsetType.right,depth)}
        if(StyleParser.index(skin.style!, CSS.LineOffsetType.top,depth) > lineOffsetTypeIndex){ offsetType.top = StylePropertyParser.string(skin, CSS.LineOffsetType.top,depth)}
        if(StyleParser.index(skin.style!, CSS.LineOffsetType.bottom,depth) > lineOffsetTypeIndex){ offsetType.bottom = StylePropertyParser.string(skin, CSS.LineOffsetType.bottom,depth)}
        return offsetType
    }
    private static var textMetricPattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
    /**
     * Returns TextFormat
     * TODO: Needs more refactoring, use functional programing and reduce
     */
    static func textFormat(_ skin:TextSkin)->TextFormat {
        var textFormat:TextFormat = TextFormat()
        let strings:[String] = TextFormatConstants.textFormatPropertyNames
        strings.forEach { textFormatKey in//TODO: Use flatMap here
            if var value:Any = StylePropertyParser.value(skin, textFormatKey){
                if StringAsserter.metric("\(String(describing: value))") {
                    let stringValue:String = "\(String(describing: value))"
                    let matches = stringValue.matches(textMetricPattern)
                    matches.forEach { match in
                        let val:Any = match.value(stringValue, 1)/*Capturing group 1*/
                        let suffix:String = match.value(stringValue, 2)/*Capturing group 2*/
                        if(suffix == CSS.Text.ems) {value = "\(val)".cgFloat * CSS.Text.emsFontSize }
                    }
                }
                if let strArr = value as? [String] { value = StringModifier.combine(strArr, " ") }/*Some fonts are seperated by a space and thus are converted to an array*/
                textFormat[textFormatKey] = value
            }
        }
        return textFormat
    }
    /**
     * Returns asset url
     * TODO: ⚠️️ this should be improved by using an AssetType struct or something, or aybe tuple?
     */
    static func asset(_ skin:Skinable, _ depth:Int = 0) -> String {
        guard let val = value(skin, CSS.Other.fill,depth),
            let arr = val as? [Any],
            let str = arr[0] as? String else {
                fatalError("no asset in \(skin) at depth: \(depth)")
        }
        return str
    }
    /**
     * TODO: ⚠️️ This method is asserted before its used, so you may ommit the optionality
     */
    static func dropShadow(_ skin:Skinable, _ depth:Int = 0)->DropShadow? {
        return value(skin, CSS.Other.drop_shadow,depth) as? DropShadow
    }
}
extension StylePropertyParser{
    /*
     * Convenince method for deriving CGFloat values
     */
    static func number(_ skin:Skinable, _ propertyName:String, _ depth:Int = 0)->CGFloat{
        return string(skin, propertyName, depth).cgFloat//was cast like this-> CGFloat(Double()!)
    }
    /**
     * Convenince method for deriving String values
     */
    static func string(_ skin:Skinable, _ propertyName:String, _ depth:Int = 0)->String{
        return "\(value(skin, propertyName, depth))"
    }
}
//private
extension StylePropertyParser{
    /**
     * Returns a GradientFillStyle
     */
    fileprivate static func gradientFillStyle(_ gradient:IGradient) -> GradientFillStyle {
        return GradientFillStyle(gradient,NSColor.clear)
    }
    /**
     * Returns a GradientLineStyle
     * NOTE: We use line-thickness because the property thickness is occupid by textfield.thickness
     */
    fileprivate static func gradientLineStyle(_ gradient:IGradient, _ skin:Skinable, _ depth:Int = 0) -> GradientLineStyle {
        let lineThickness:CGFloat = value(skin, CSS.Other.lineThickness,depth) as! CGFloat
        return GradientLineStyle(gradient, lineThickness, NSColor.clear)
    }
    /**
     * Returns a LineStyle instance
     * TODO: this is wrong the style property named line-color doesnt exist anymore, its just line now
     * NOTE: we use line-thickness because the property thickness is occupid by textfield.thickness
     */
    fileprivate static func colorLineStyle(_ colorValue:NSColor?, _ skin:Skinable, _ depth:Int = 0) -> LineStylable {
        let lineThickness:CGFloat = value(skin, CSS.Other.lineThickness,depth) as? CGFloat ?? CGFloat.nan
        let lineAlpha:CGFloat = value(skin, CSS.Other.lineAlpha,depth) as? CGFloat ?? 1
        let nsColor:NSColor = colorValue != nil ? colorValue!.alpha(lineAlpha) : NSColor.clear
        return LineStyle(lineThickness, nsColor)
    }
    /**
     * NOTE: makes sure that if the value is set to "none" or doesnt exsist then NaN is returned (NaN is interpreted as do not draw or apply style)
     */
    fileprivate static func color(_ skin:Skinable, _ propertyName:String, _ depth:Int = 0) -> NSColor? {
        let color:Any? = value(skin, propertyName,depth)
        return color == nil || (color as? String) == CSS.Align.none ? nil : color as? NSColor
    }
    /**
     * Returns a FillStyle instance
     * TODO: add support for the css: fill:none; (the current work-around is to set fill-alpha:0)
     * TODO: ⚠️️ I don't think we need support for array anymore, consider removing it
     */
    fileprivate static func colorFillStyle(_ colorVal:Any?,_ skin:Skinable, _ depth:Int = 0)->FillStyleKind {
        var nsColor:NSColor? = {
            if let colorVal = colorVal as? NSColor {
                return colorVal
            }else if let colorVals = colorVal as? [Any] {
                if let colorVal = colorVals[safe:1]{
                    if let colorValStr = colorVal as? String, colorValStr == CSS.Align.none{
                        return nil
                    }else if let colorValNSColor = colorVal as? NSColor{
                        return colorValNSColor
                    }else{
                        fatalError("type not supported, must be nsColor or string that is equal to CSSConstants.none")
                    }
                }else{
                    fatalError("colorValue not supported: " + "\(String(describing: colorVal))")
                }
            }else{
                return nil
            }
        }()
        let alpha:Any? = StylePropertyParser.value(skin,CSS.Other.fillAlpha,depth)
        let alphaValue:CGFloat = alpha as? CGFloat ?? 1
        nsColor = nsColor != nil ? nsColor!.alpha(alphaValue) : NSColor.clear/*<-- if color is NaN, then the color should be set to clear, or should it?, could we instad use nil, but then we would need to assert all fill.color values etc, we could create a custom NSColor class, like NSEmptyColor that extends NSCOlor, since we may want NSColor.clear in the future, like clear the fill color etc? clear is white with alpha 0.0*/
        return FillStyle(nsColor!)
    }
}

//Deprecate

/**
 * NOTE: this is really a modifier method
 * TODO: add support for % (this is the percentage of the inherited font-size value, if none is present i think its 12px)
 */
/*static func textField(_ skin:TextSkin) {
    for textFieldKey:String in TextFieldConstants.textFieldPropertyNames {
        let value:Any? = StylePropertyParser.value(skin,textFieldKey)
        if(value != nil) {
            if(StringAsserter.metric(value as! String)){
                //TODO: You may need to set one of the inner groups to be non-catchable
                let pattern:String = "^(-?\\d*?\\.?\\d*?)((%|ems)|$)"
                let stringValue:String = "\(value)"//swift 3 update
                let matches = stringValue.matches(pattern)
                for match:NSTextCheckingResult in matches {
                    var value:Any = match.value(stringValue,1)/*Capturing group 1*/
                    let suffix:String = match.value(stringValue,2)/*Capturing group 2*/
                    if(suffix == CSSConstants.ems) {value = "\(value)".cgFloat * CSSConstants.emsFontSize }
                }
            }
            //TODO: this needs to be done via subscript probably, see that other code where you used subscripting recently
            fatalError("Not implemented yet")
            //skin.textField[textFieldKey] = value
        }
    }
    fatalError("out of order")
}*/

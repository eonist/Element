import Foundation
/**
 *  // :TODO: Add support for bottom top left right values in normal css values
 *  // :TODO: support for radialGradient: css w3c
 *  // :TODO: // make a pattern for all the w3c color shortcuts svg colors 116 colors
 */
class CSSPropertyParser {
    /**
     * Retuns a css property to a property that can be read by the flash api
     */
    class func property(string:String) -> Any{//:TODO: Long switch statments can be replaced by polymorphism?!?
        Swift.print("CSSPropertyParser.property() string: " + string)
        switch(true) {
            case StringAsserter.digit(string):Swift.print("isDigit");return StringParser.digit(string);/*40 or -1 or 1.002 or 12px or 20% or .02px*/
            case StringAsserter.metric(string):Swift.print("isMetric");return string;//ems|%
            case StringAsserter.boolean(string):return StringParser.boolean(string);/*true or false*/
            case StringAsserter.color(string):return StringParser.color(string);/*#00ff00 or 00ff00*/
            case StringAsserter.webColor(string):return StringParser.color(string);/*green red etc*/
            case RegExp.test(string,"^linear-gradient\\b"):return linearGradient(string);/*linear-gradient*/// :TODO: create a more complte exprrison for this test
            case RegExp.test(string,"^textFormat\\b"):return textFormat(string);
            case RegExp.test(string,"^textField\\b"):return textField(string);
            case RegExp.test(string,"^([\\w\\d\\/\\%\\-\\.]+?\\\040)+?(\\b|\\B|$)"):Swift.print("isArray");return array(string);/*corner-radius, line-offset-type, margin, padding, offset*/// :TODO: shouldnt the \040 be optional?
            case RegExp.test(string,"(?=[a-zA-z]*\\d*[a-zA-z]*\\d*)[a-zA-z]+"):Swift.print("isString");return string/* string (Condition: someName1 | someName | but not just a number by it self);*/ //:TODO: this needs to also test if it is a contining word. ^pattern$ so not to match linear-gradient or you can test that its nothing els than words or number? // :TODO: what does it do?
            default : fatalError("CSSPropertyParser.property() THE: " + string + " PROPERTY IS NOT SUPPORTED");
        }
    }
    
    
    
    /**
    * // :TODO: possibly use the RegExp.exec to loop the properties!!
    * @param string "linear-gradient(top,gray 1 0,white 1 1);"// 2 color gradient
    * @Note setting the gradientType isnt necessary since its the default setting
    */
    class func linearGradient(string:String)->IGradient{
        //Swift.print("CSSPropertyparser.linearGradient")
        let propertyString:String = RegExp.match(string, "(?<=linear-gradient\\().+?(?=\\);?)")[0]
        var properties:Array<String> = StringModifier.split(propertyString, ",")
        let rotation:CGFloat = Utils.rotation(ArrayModifier.shift(&properties));/*the first item is always the rotation, top or left or top left etc*/
        var gradient:IGradient = Utils.gradient(properties);/*add colors, opacities and ratios*/
        gradient.rotation = Trig.normalize2(rotation * ㎭);// :TODO: rotations should be applied in the matrix
        Swift.print("gradient.rotation: " + "\(gradient.rotation)")
        return gradient;
    }
    /**
     * Returns an array comprised of values if the individual value is a digit then it is processed as a digit if its not a digit then its just processed as a string
     * // :TODO: does this support comma delimited lists?
     * EXAMPLE: a corner-radius "10 20 10 20"
     */
    class func array(string:String)->Array<Any>{
        Swift.print("CSSPropertyParser.array()")
        let matches:Array<String> = StringModifier.split(string, " ")
        var array:Array<Any> = [];
        for str : String in matches { array.append(StringAsserter.digit(str) ? StringParser.digit(str) : str) }
        return array;
    }
    /**
    * TextFormat
    * // :TODO: should possibly return a TextFormat class instance or alike
    */
    class func textFormat(input : String) -> Dictionary<String,Any> {
        var textFormat:Dictionary<String,Any> = Dictionary<String,Any>();
        let pattern:String = "(?<=textFormat\\().+?(?=\\);?)"
        let propertyString:String = RegExp.match(input,pattern)[0]
        let properties:Array<String> = StringParser.split(propertyString, ",")
        for property:String in properties{
            let matches:Array<NSTextCheckingResult> = RegExp.matches(property,"^(\\w+?)\\:(.+?)$");
            for match:NSTextCheckingResult in matches{
                let name:String = (property as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
                var value:Any = (property as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 2
                if(name  == "color") { value = StringParser.color(value as! String) }
                else if(String(value) == "true") {value = true }
                else if(String(value) == "false") {value = false }
                //else {StringParser.boolean(String(value))}
                //Swift.print("CSSPropertyParser.textFormat() value: " + "\(value)")
                textFormat[name] = value;
            }
        }
        return textFormat;
    }
    /**
     * Textfield
     * // :TODO: should possibly return a TextField class instance or alike
     */
    class func textField(input:String)->Dictionary<String,Any>{
        var textField:Dictionary<String,Any> = Dictionary<String,Any>();
        let propertyString:String = input.match("(?<=textField\\().+?(?=\\);?)")[0]
        var properties:Array = propertyString.split(",")
        for (var i : Int = 0; i < properties.count; i++) {
            let property:String = properties[i];
            let matches:Array<NSTextCheckingResult> = property.matches("^(\\w+?)\\:(.+?)$");
            for match:NSTextCheckingResult in matches {
                let name:String = (property as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
                var value:Any = (property as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 2
                if(name == "textColor" || name == "backgroundColor" || name ==  "borderColor") { value = StringParser.color(value as! String)}
                else if(value as! String == "true") { value = true }
                else if(value as! String == "false") { value = false }
                textField[name] = value;
            }
        }
        return textField;
    }
}
private class Utils{
    /**
     * Returns a Gradient instance derived from @param properties
     * @Note adds colors, opacities and ratios
     */
    class func gradient(properties:Array<String>)->IGradient {
        //print("CSSPropertyparser: Utils.gradient.properties: " + String(properties));
        let gradient:Gradient = Gradient();
        for (var i : Int = 0; i < properties.count; i++) {// :TODO: add support for all Written Color. find list on w3c
            let property:String = properties[i];
            let pattern:String = "^\\s?([a-zA-z0-9#]*)\\s?([0-9%\\.]*)?\\s?([0-9%\\.]*)?$"
            
            let matches:Array<NSTextCheckingResult> = RegExp.matches(property, pattern)
            //Swift.print("matches.count: " + "\(matches.count)")
            for match:NSTextCheckingResult in matches {
                //Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
                //let content = RegExp.value(property, match, 0)//the entire match
                let color:String = RegExp.value(property, match, 1)
                //Swift.print("color: " + color)
                
                let alpha:String = RegExp.value(property, match, 2)
                //Swift.print("alpha: " + alpha)
                
                let alphaVal:Float = Float(Utils.alpha(alpha))
                gradient.colors.append(ColorParser.cgColor(StringParser.color(color,alphaVal)))//append color
                
                let ratio:String = RegExp.value(property, match, 3)
                //Swift.print("ratio: " + ratio)
                
                var ratioValue:Double = Utils.ratio(ratio)
                if(ratioValue.isNaN) { ratioValue = (Double(i) / (Double(properties.count)-1.0)) /** 255.0*/ }/*if there is no ratio then set the ratio to its natural progress value and then multiply by 255 to get valid ratio values*/
                //Swift.print("gradient.locations start: " + "\(gradient.locations.count)")
                gradient.locations.append(CGFloat(Float(ratioValue)))//append ratioValue
                //Swift.print("gradient.locations end: " + "\(gradient.locations.count)")
            }
        }
        return gradient
    }
    /**
     *
     */
    class func rotation(rotationMatch:String)->CGFloat{//td move to internal utils class?or maybe not?
        var rotation:CGFloat;
        let directionPattern:String = "left|right|top|bottom|top left|top right|bottom right|bottom left" // :TODO: support for tl tr br bk l r t b?
        if(RegExp.test(rotationMatch,"^\\d+?deg|\\d+$")) {
            rotation = CGFloat(Double(RegExp.match(rotationMatch, "^\\d+?$|^\\d+?(?=deg$)")[0])!)
        }
        else if(RegExp.test(rotationMatch,directionPattern)){
            let angleType:String = RegExp.match(rotationMatch,directionPattern)[0]
            rotation = Trig.angleType(angleType)-180.0;// :TODO: Create support for top left and other corners
        }else{fatalError("Error")}
        //		trace("rotation: " + rotation);
        return rotation;
    }
    /**
     * // :TODO: add support for auto ratio values if they are not defined, you have implimented this functionality somewhere, so find this code
     */
    class func ratio(var ratio:String)->Double{
        var ratioValue:Double = Double.NaN
        if(RegExp.test(ratio,"\\d{1,3}%")){//i.e: 100%
            ratio = RegExp.match(ratio,"\\d{1,3}")[0]
            ratioValue = Double(ratio)! / 100 /** 255*/
        }else if(RegExp.test(ratio,"\\d\\.\\d{1,3}|\\d")){ ratioValue = Double(ratio)! /** 255*/ } //i.e: 0.9// :TODO: suport for .2 syntax (now only supports 0.2 syntax)
        return ratioValue;
    }
    /**
     *
     */
    class func alpha(var alpha:String)->Double{
        var alphaValue:Double = 1
        if(RegExp.test(alpha,"\\d{1,3}%")){//i.e: 100%
            alpha = RegExp.match(alpha,"\\d{1,3}")[0];
            alphaValue = Double(alpha)!/100
        }else if(RegExp.test(alpha,"\\d\\.\\d{1,3}|\\d")) {alphaValue = Double(alpha)!}//i.e: 0.9// :TODO: suport for .2 syntax (now only supports 0.2 syntax)
        else if(RegExp.test(alpha,"^$")) {alphaValue = 1}//no value present
        return alphaValue;
    }
}
/*
// :TODO: Maybe support for color values like: 0x00ff00 and 00ff00
// :TODO: maybe support for rotation values in radiens? and scalar?
// :TODO: radial-gradient support
linear-gradient(90deg|90|left|right|top|bottom|, #B1D0DE 0.5|50%| 0.2|20%|, #F3F8F9 0.3|30%| 0.1|10%|);//rotation,firstStop(color,ratio,alpha),secondStop(color,ratio,alpha),and so on

// :TODO: write similar syntax:
<linear-gradient> = linear-gradient(
[
[ [top | bottom] || [left | right] ]
|
<angle>
,]?
<color-stop>[, <color-stop>]+
);

*/

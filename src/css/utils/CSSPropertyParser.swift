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
        switch(true) {
            case StringAsserter.digit(string):return StringParser.digit(string);/*40 or -1 or 1.002 or 12px or 20% or .02px*/
            case StringAsserter.metric(string):return string;
            case StringAsserter.boolean(string):return StringParser.boolean(string);/*true or false*/
            case StringAsserter.color(string):return StringParser.color(string);/*#00ff00 or 00ff00*/
            case StringAsserter.webColor(string):return StringParser.color(string);/*green red etc*/
            
            case RegExp.test(string,"^linear-gradient\\b"):return linearGradient(string);/*linear-gradient*/// :TODO: create a more complte exprrison for this test
            case RegExp.test(string,"^([\\w\\d\\/\\%\\-\\.]+?\\\040)+?(\\b|\\B|$)"):return array(string);/*corner-radius, line-offset-type, margin, padding, offset*/// :TODO: shouldnt the \040 be optional?
            default : fatalError("CSSPropertyParser.property() THE: " + string + " PROPERTY IS NOT SUPPORTED");
        }
    }
    /**
    * // :TODO: possibly use the RegExp.exec to loop the properties!!
    * @param string "linear-gradient(top,gray 1 0,white 1 1);"// 2 color gradient
    * @Note setting the gradientType isnt necessary since its the default setting
    */
    class func linearGradient(string:String)->IGradient{
        
        var propertyString:String = RegExp.match(string, "(?<=linear-gradient\\().+?(?=\\);?)")[0]
        var properties:Array<String> = StringModifier.split(propertyString, ",")
        var rotation:Double = Utils.rotation(ArrayModifier.shift(&properties));/*the first item is always the rotation, top or left or top left etc*/
        var gradient:IGradient = Utils.gradient(properties);/*add colors, opacities and ratios*/
        gradient.rotation = rotation*Trig.RAD;// :TODO: rotations should be applied in the matrix
        return gradient;
    }
    /**
     * Returns an array comprised of values if the individual value is a digit then it is processed as a digit if its not a digit then its just processed as a string
     * // :TODO: does this support comma delimited lists?
     * EXAMPLE: a corner-radius "10 20 10 20"
     */
    class func array(string:String)->Array<Any>{
        let matches:Array<String> = StringModifier.split(string, " ")
        var array:Array<Any> = [];
        for str : String in matches { array.append(StringAsserter.digit(str) ? StringParser.digit(str) : str) }
        return array;
    }
}
class Utils{
    /**
    * Returns a Gradient instance derived from @param properties
    * @Note adds colors, opacities and ratios
    */
    class func gradient(properties:Array<String>)->IGradient {
        print("properties: " + String(properties));
        var gradient:Gradient = Gradient();
        for (var i : Int = 0; i < properties.count; i++) {// :TODO: add support for all Written Color. find list on w3c
            var property:String = properties[i];
            let pattern:String = "^\\s?([a-zA-z0-9#]*)\\s?([0-9%\\.]*)?\\s?([0-9%\\.]*)?$"
            
            let matches:Array<NSTextCheckingResult> = RegExp.matches(property, pattern)
            for match:NSTextCheckingResult in matches {
                match.numberOfRanges
                //let content = RegExp.value(property, match, 0)//the entire match
                let color:String = RegExp.value(property, match, 1)
                
                let alpha:String = RegExp.value(property, match, 2)
                gradient.colors.append(ColorParser.cgColor(StringParser.color(color,Float(alpha)!)))
                
                let ratio:String = RegExp.value(property, match, 3)
                gradient.locations.append(CGFloat(Float(ratio)!))
            }
            /*
            var matches:Array = property.match();
                gradient.colors.push(StringParser.color(matches["color"]));
                gradient.alphas.push(Utils.alpha(matches["alpha"]));
                var ratioValue:Number = Utils.ratio(matches["ratio"]);
                if(isNaN(ratioValue)) ratioValue = (i / (properties.length-1))*255;/*if there is no ratio then set the ratio to its natural progress value and then multiply by 255 to get valid ratio values*/
                gradient.ratios.push(ratioValue);
                }
                return gradient;
            */
        }
    }
    class func rotation(rotationMatch:String)->Double{//td move to internal utils class?or maybe not?
        var rotation:Double;
        let directionPattern:String = "left|right|top|bottom|top left|top right|bottom right|bottom left" // :TODO: support for tl tr br bk l r t b?
        if(RegExp.test(rotationMatch,"^\\d+?deg|\\d+$")) {
            rotation = Double(RegExp.match(rotationMatch, "^\\d+?$|^\\d+?(?=deg$)")[0])!
        }
        else if(RegExp.test(rotationMatch,directionPattern)){
            let angleType:String = RegExp.match(rotationMatch,directionPattern)[0]
            rotation = Trig.angleType(angleType)+180;// :TODO: Create support for top left and other corners
        }
        //		trace("rotation: " + rotation);
        return rotation;
    }
}

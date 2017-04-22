import Cocoa
@testable import Utils
/**
 * TODO: Add support for bottom top left right values in normal css values
 * TODO: Support for radialGradient: css w3c
 * TODO: Make a pattern for all the w3c color shortcuts svg colors 116 colors
 */
class CSSPropertyParser {
    /**
     * Retuns a css property to a property that can be read by the Swift API
     * TODO: Long switch statments can be replaced by polymorphism?!?
     */
    static func property(_ string:String) -> Any{
        switch(true) {
            case StringAsserter.digit(string):/*Swift.print("isDigit");*/return StringParser.digit(string)/*40 or -1 or 1.002 or 12px or 20% or .02px*/
            case StringAsserter.metric(string):/*Swift.print("isMetric");*/return string//ems|%TODO: // should retirn a new type named EMS()
            case StringAsserter.boolean(string):return StringParser.boolean(string)/*true or false*/
            case StringAsserter.color(string):return StringParser.nsColor(string)/*#00ff00 or 00ff00*/
            case StringAsserter.webColor(string):return StringParser.nsColor(string)/*green red etc*/
            case RegExp.test(string,"^linear-gradient\\b"):return linearGradient(string)/*linear-gradient*/// :TODO: create a more complte exprrison for this test
            case RegExp.test(string,"^radial-gradient\\b"):return radialGradient(string)/*radial-gradient*/// :TODO: create a more complte exprrison for this test
            case RegExp.test(string,"^drop-shadow\\b"):return dropShadow(string)/*drop-shadow*/
            case RegExp.test(string,"^textFormat\\b"):return textFormat(string)
            case RegExp.test(string,"^textField\\b"):return textField(string)
            case RegExp.test(string,"^([\\w\\d\\/\\%\\-\\.~]+?\\040)+?(\\b|\\B|$)"):/*Swift.print("isArray");*/return array(string)/*corner-radius, line-offset-type, margin, padding, offset, svg asset, font names*/// :TODO: shouldnt the \040 be optional? added ~ char for relative path support
            case RegExp.test(string,"(?=[a-zA-z]*\\d*[a-zA-z]*\\d*)[a-zA-z]+"):/*Swift.print("isString");*/return string/* string (Condition: someName1 | someName | but not just a number by it self);*/ //:TODO: this needs to also test if it is a contining word. ^pattern$ so not to match linear-gradient or you can test that its nothing els than words or number? // :TODO: what does it do?
            default : fatalError("CSSPropertyParser.property() THE: " + string + " PROPERTY IS NOT SUPPORTED")
        }
    }
    /**
     * PARAM: string "linear-gradient(top,gray 1 0,white 1 1);"// 2 color gradient
     * NOTE: setting the gradientType isn't necessary since its the default setting
     * TODO: possibly use the RegExp.exec to loop the properties!!
     */
    static func linearGradient(_ string:String)->IGradient{
        let propertyString:String = RegExp.match(string, "(?<=linear-gradient\\().+?(?=\\);?)")[0]
        var properties:[String] = StringModifier.split(propertyString, ",")
        let rotation:CGFloat = Utils.rotation(ArrayModifier.shift(&properties))/*the first item is always the rotation, top or left or top left etc*/
        var gradient:IGradient = LinearGradient(Utils.gradient(properties))/*add colors, opacities and ratios*/
        gradient.rotation = Trig.normalize2(rotation * ㎭)/*should pin the angle between -π and +π*///TODO: rotations should be applied in the matrix
        return gradient
    }
    /**
     * PARAM: string radial-gradient(50% 50% 100% 100% 1,blue 1 0,red 1 1);//2 color radial-gradient, with focalPointRatio and with percentage of x,y,width and height
     * NOTE: color: color,alpha,gradiant-ratio (aka gradient-location)
     * NOTE: The first and second % variables makes out the location of the radial gradient
     * NOTE: the third and fourth % variables makes out the width and the height of the radial gradient
     * NOTE: the variable after the % variables makes out the rotation in degrees (0,90,180 etc) (similar to linear gradient)
     * NOTE: the variable after the rotation variables makes out the focal ratio (-1 to +1)
     * NOTE: The location of the focal point is defined as a scalar position from p1 to p2.
     * NOTE: p1 is defined by the negative direction of the rotation value (5th var) from the center pos (defined by the 1st and 2nd % vars)  until it hits an edge of the gradientBox (a bounding box that garantues to cover the entire boundingbox of a path)
     * NOTE: p2 is the same as p1 but in the direction of the rotation.
     * NOTE: The only thing you cant adjust is the width and height of the startingPoint of the radialgradient (you can simulate this by increasing the entire size of the shape, and similarly decreaseing the size of the endPoint) TODO: can this be done better in css? sure it can. but this works for now.
     * NOTE: CSS3 has this code to semi support 2 point radial gradients. background: radial-gradient(1 20px 40px, 2 farthest-side, 3 white 20%, 4 magenta) I suppose you may be able to achive any 2 point radial gradient this way but its difficult to say
     * NOTE: A better css syntax would be: radial-gradient(x1 y1 w1 h1 x2 y2 w2 h2,color alpha ratio) and if supply only the first 4 % variables then the center and the focal point is the same and you get an "uniform spread"
     * NOTE: somehow also add support for: reflect and repeat
     * NOTE: the reason we do it this way is that this approach can make any 2 point radial gradient. some scaling may be needed
     * IMPORTANT:⚠️️
     * SpreadMethod.REFLECT
     * SpreadMethod.REPEAT
     * SpreadMethod.PAD for the spread
     * TODO: create a small app that generates the radial-gradient from an svg
     * TODO: possibly use the RegExp.exec to loop the properties!!
     */
     static func radialGradient(_ string:String)->IGradient{
        let propertyString:String = string.match("(?<=radial-gradient\\().+?(?=\\);?)")[0]
        var properties:[String] = StringModifier.split(propertyString, ",")
        let setupString:String = properties.shift()
        let gradient:RadialGradient = RadialGradient(Utils.gradient(properties))/*add colors, opacities and ratios*/
        //gradient.colors[0]
        let setup:[String] = setupString.split(" ")/*The gradient settings*/
        let x:CGFloat = StringParser.percentage(setup[0])/100/*percentage wise*/// TODO: make this optional aswell as per css pdf specs
        let y:CGFloat = StringParser.percentage(setup[1])/100/*percentage wise*/
        let xScale:CGFloat = setup.count > 2 ? StringParser.percentage(setup[2])/100:1
        let yScale:CGFloat = setup.count > 3 ? StringParser.percentage(setup[3])/100:1
        let rotation:CGFloat = setup.count > 4 ? CGFloat(Double(setup[4])!) * ㎭ : 0/*from rotation in degrees*/
        gradient.rotation = rotation
        gradient.startCenter = CGPoint(0,setup.count == 6 ? setup[5].cgFloat : 0)/*the last item is always the focalPointRatio always between -1 to 1*/
        gradient.startRadius = CGSize(0,0)
        gradient.endCenter = CGPoint(x,y)
        gradient.endRadius = CGSize(yScale,xScale)/*<---We re-order the values here, I think its best to do the correct order but as this is the way CSS does it we also do it this way, to support the correct order you will have to manually switch the css themes for these values*/
        return gradient
     }
    /**
     * Returns an array comprised of values if the individual value is a digit then it is processed as a digit if its not a digit then its just processed as a string
     * EXAMPLE: a corner-radius "10 20 10 20"
     * TODO: does this support comma delimited lists?
     */
    static func array(_ string:String)->[Any]{//<--Any because type can be CGFloat, String or NSColor
        let matches:[String] = StringModifier.split(string, " ")
        let array:[Any] = matches.map { str in
            if(StringAsserter.digit(str)){
                return StringParser.digit(str)
            }else if(StringAsserter.color(str) || StringAsserter.webColor(str)){
                return StringParser.nsColor(str)
            }else{
                return str
            }
        }
        return array
    }
    /**
     * TextFormat
     * RETURNS a TextFormat class instance
     */
    static func textFormat(_ input:String) -> TextFormat {
        let textFormat:TextFormat = TextFormat()
        let pattern:String = "(?<=textFormat\\().+?(?=\\);?)"
        let propertyString:String = RegExp.match(input,pattern)[0]
        let properties:[String] = StringParser.split(propertyString, ",")
        for property:String in properties{
            let matches:[NSTextCheckingResult] = RegExp.matches(property,"^(\\w+?)\\:(.+?)$");
            for match:NSTextCheckingResult in matches{
                let name:String = match.value(property, 1)/*Capturing group 1*/
                var value:Any = match.value(property, 2)/*Capturing group 2*/
                if(name == "color") { value = StringParser.nsColor(value as! String) }
                else if("\(value)" == "true") {value = true }
                else if("\(value)" == "false") {value = false }
                //else {StringParser.boolean(String(value))}
                textFormat[name] = value
            }
        }
        return textFormat
    }
    /**
     * Textfield
     * TODO: should possibly return a TextField class instance or alike
     */
    static func textField(_ input:String)->Dictionary<String,Any>{
        var textField:Dictionary<String,Any> = Dictionary<String,Any>()
        let propertyString:String = input.match("(?<=textField\\().+?(?=\\);?)")[0]
        var properties:Array = propertyString.split(",")
        for i in 0..<properties.count{//swift 3 update
            let property:String = properties[i]
            let matches:[NSTextCheckingResult] = property.matches("^(\\w+?)\\:(.+?)$")
            for match:NSTextCheckingResult in matches {
                let name:String = match.value(property,1)/*capturing group 1*/
                var value:Any = match.value(property,2)/*capturing group 2*/
                ["textColor","backgroundColor","borderColor"]
                if(name) { value = StringParser.nsColor(value as! String)}
                else if(value as! String == "true") { value = true }
                else if(value as! String == "false") { value = false }
                textField[name] = value
            }
        }
        fatalError("out of order")
        //return textField
    }
    /**
     * Returns a DropShadowFilter instance
     */
    static func dropShadow(_ string:String)->DropShadow {
        let propertyString:String = string.match("(?<=drop-shadow\\().+?(?=\\);?)")[0]
        var properties:Array = propertyString.split(" ")
        let distance:CGFloat = StringParser.digit(properties[0])
        let angle:CGFloat = StringParser.digit(properties[1])/*In degrees*/
        let colorValue:UInt = StringParser.color(properties[2])/*hex color*/
        let alpha:CGFloat = StringParser.digit(properties[3])
        let blurX:CGFloat = StringParser.digit(properties[4])
        let blurY:CGFloat = StringParser.digit(properties[5])
        let inner:Bool = StringParser.boolean(properties[8])/*isInnerShadow,isInsetShadowType etc*/
        let color:NSColor = NSColorParser.nsColor(colorValue, alpha)
        let blur:CGFloat = max(blurX,blurY)
        let angleInRadians = Trig.radians(angle)
        let polarPoint:CGPoint = PointParser.polar(distance, angleInRadians)/*finds the point from x:0,y:0*/
        let offsetX:CGFloat = polarPoint.x
        let offsetY:CGFloat = polarPoint.y
        let dropShadow:DropShadow = DropShadow(color,offsetX,offsetY,blur,inner)
        return dropShadow
    }
}
private class Utils{
    /**
     * Returns a Gradient instance derived from PARAM: properties
     * NOTE: adds colors, opacities and ratios
     */
    static func gradient(_ properties:[String])->IGradient {
        //print("CSSPropertyparser: Utils.gradient.properties: " + String(properties));
        let gradient:Gradient = Gradient()
        for i in 0..<properties.count{//swift 3 update//TODO: add support for all Written Color. find list on w3c
            let property:String = properties[i]
            let pattern:String = "^\\s?([a-zA-z0-9#]*)\\s?([0-9%\\.]*)?\\s?([0-9%\\.]*)?$"
            let matches:[NSTextCheckingResult] = RegExp.matches(property, pattern)
            //Swift.print("matches.count: " + "\(matches.count)")
            for match:NSTextCheckingResult in matches {
                //Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
                //let content = RegExp.value(property, match, 0)//the entire match
                let color:String = match.value(property,1)
                //Swift.print("color: " + color)
                let alpha:String = match.value(property, 2)
                //Swift.print("alpha: " + alpha)
                let alphaVal:CGFloat = Utils.alpha(alpha).cgFloat
                //Swift.print("alphaVal: " + "\(alphaVal)")
                gradient.colors.append(CGColorParser.cgColor(StringParser.color(color),alphaVal))//append color
                let ratio:String = RegExp.value(property, match, 3)
                //Swift.print("ratio: " + ratio)
                var ratioValue:Double = Utils.ratio(ratio)
                if(ratioValue.isNaN) { ratioValue = (i.double / (properties.count.double-1.0)) /** 255.0*/ }/*if there is no ratio then set the ratio to its natural progress value and then multiply by 255 to get valid ratio values*/
                //Swift.print("gradient.locations start: " + "\(gradient.locations.count)")
                gradient.locations.append(ratioValue.cgFloat)//append ratioValue
                //Swift.print("gradient.locations end: " + "\(gradient.locations.count)")
            }
        }
        return gradient
    }
    /**
     *
     */
    static func rotation(_ rotationMatch:String)->CGFloat{//td move to internal utils class?or maybe not?
        var rotation:CGFloat;
        let directionPattern:String = "left|right|top|bottom|top left|top right|bottom right|bottom left" // :TODO: support for tl tr br bk l r t b?
        if(RegExp.test(rotationMatch,"^\\d+?deg|\\d+$")) {
            rotation = CGFloat(Double(RegExp.match(rotationMatch, "^\\d+?$|^\\d+?(?=deg$)")[0])!)
        }
        else if(RegExp.test(rotationMatch,directionPattern)){
            let angleType:String = RegExp.match(rotationMatch,directionPattern)[0]
            rotation = Trig.angleType(angleType)-180.0// :TODO: Create support for top left and other corners
        }else{fatalError("Error")}
        //Swift.print("rotation: " + rotation)
        return rotation
    }
    /**
     * // :TODO: add support for auto ratio values if they are not defined, you have implimented this functionality somewhere, so find this code
     */
    static func ratio(_ ratio:String)->Double{//<--Why not CGFloat?
        var ratio = ratio
        var ratioValue:Double = Double.nan
        if(RegExp.test(ratio,"\\d{1,3}%")){/*i.e: 100%*/
            ratio = RegExp.match(ratio,"\\d{1,3}")[0]
            ratioValue = ratio.double / 100/*255*/
        }else if(RegExp.test(ratio,"\\d\\.\\d{1,3}|\\d")){ ratioValue = ratio.double /** 255*/ } //i.e: 0.9// :TODO: suport for .2 syntax (now only supports 0.2 syntax)
        return ratioValue
    }
    /**
     * TODO: We should use CGFloat here not Double
     */
    static func alpha(_ alpha:String)->Double{
        var alpha = alpha
        var alphaValue:Double = 1
        if(RegExp.test(alpha,"\\d{1,3}%")){/*i.e: 100%*/
            alpha = RegExp.match(alpha,"\\d{1,3}")[0]
            alphaValue = alpha.double/100
        }else if(RegExp.test(alpha,"\\d\\.\\d{1,3}|\\d")) {alphaValue = alpha.double}//i.e: 0.9// :TODO: suport for .2 syntax (now only supports 0.2 syntax)
        else if(RegExp.test(alpha,"^$")) {alphaValue = 1}//no value present
        return alphaValue
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

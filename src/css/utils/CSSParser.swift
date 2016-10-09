import Foundation
/*
 * // :TODO: if you strip the inital css data for spaces then you wont need to removeWrappingWhiteSpace all the time
 * // :TODO: use Vector<String> for speed etc, vector is faster for array yes but not for associate object array?
 */
class CSSParser{
    static let precedingWith:String = "(?<=^|\\})"
    static let nameGroup:String = "([\\w\\s\\,\\[\\]\\.\\#\\:]*?)"
    static let valueGroup:String = "((?:.|\\n)*?)"
    static let CSSElementPattern:String = precedingWith + nameGroup + "\\{" + valueGroup + "\\}"/*this pattern is here so that its not recrated every time*/
    enum CSSElementType:Int{ case name = 1, value}
    /**
     * Returns a StyleCollection populated with Style instances, by converting a css string and assigning each style to a Styleclass and then adding these to the StyleCollection
     * PARAM: cssString: a string comprised by css data h1{color:blue;} etc
     * RETURN: StyleCollection populated with Styles
     * NOTE:: We can't sanitize the cssString for whitespace becuase whitespace is needed to sepereate some variables (i.e: linear-gradient)
     */
    class func styleCollection(cssString:String)->IStyleCollection{
        //Swift.print("CSSParser.styleCollection()")
        let styleCollection:IStyleCollection = StyleCollection();
        let matches = RegExp.matches(cssString, CSSElementPattern)/*Finds and seperates the name of the style and the content of the style*/// :TODO: name should be +? value also?;
        for match:NSTextCheckingResult in matches {/*Loops through the pattern*/
            let styleName:String = match.value(cssString, 1)//name
            let value:String = match.value(cssString, 1)//value
            if(StringAsserter.contains(styleName, ",") == false){
                let style:IStyle = CSSParser.style(styleName,value)
                styleCollection.addStyle(style);/*If the styleName has 1 name*/
            }else{
                let siblingStyles:Array<IStyle> = Utils.siblingStyles(styleName, value)
                styleCollection.addStyles(siblingStyles);/*If the styleName has multiple comma-seperated names*/
            }
        }
        return styleCollection
    }
    /**
     * Converts cssStyleString to a Style instance
     * Also transforms the values so that : (with Flash readable values, colors: become hex colors, boolean strings becomes real booleans etc)
     * PARAM: name: the name of the style
     * PARAM: value: a string comprised of a css style syntax (everything between { and } i.e: color:blue;border:true;)
     */
    class func style(var name:String,_ value:String)->IStyle!{
        //Swift.print("CSSParser.style() " + "name: " + name + " value: " + value)
        name = name != "" ? RegExpModifier.removeWrappingWhitespace(name) : ""/*removes space from left and right*/
        let selectors:Array<ISelector> = SelectorParser.selectors(name)
        let style:IStyle = Style(name,selectors, [])
        let pattern:String = "([\\w\\s\\,\\-]*?)\\:(.*?)\\;"
        let matches = RegExp.matches(value, pattern)
        for match:NSTextCheckingResult in matches {
            let propertyName:String = match.value(value, 1)//name
            let propertyValue:String = match.value(value, 2)//value
            let styleProperties:Array<IStyleProperty> = CSSParser.styleProperties(propertyName,propertyValue)
            style.addStyleProperties(styleProperties)
        }
        return style
    }
    /**
     * Returns an array of StyleProperty items (if a name is comma delimited it will create a new styleProperty instance for each match)
     * NOTE: now supports StyleProperty2 that can have many property values
     */
    class func styleProperties(propertyName:String, _ propertyValue:String)->Array<IStyleProperty>{
        var styleProperties:Array<IStyleProperty> = []
        let names = StringAsserter.contains(propertyName, ",") ? StringModifier.split(propertyName, propertyValue) : [propertyName]//Converts a css property to a swift compliant property that can be read by the swift api
        for var name in names {
            name = RegExpModifier.removeWrappingWhitespace(name);
            let valExp:String = "\\w\\.\\-%#\\040<>\\/~";/*expression for a single value, added the tilde char to support relative paths while in debug, could be usefull for production aswell*/
            let pattern:String = "(["+valExp+"]+?|["+valExp+"]+?\\(["+valExp+",]+?\\))(?=,|$)"/*find each value that is seperated with the "," character (value can by itself contain commas, if so thous commas are somewhere within a "(" and a ")" character)*/
            var values:Array<String> = RegExp.match(propertyValue,pattern)
            for (var i : Int = 0; i < values.count; i++) {
                var value = values[i]
                value = RegExpModifier.removeWrappingWhitespace(value)
                //Swift.print(" value: " + value)
                let propertyValue:Any = CSSPropertyParser.property(value)
                //Swift.print("propertyValue: " + "\(propertyValue)")
                let styleProperty:IStyleProperty = StyleProperty(name,propertyValue,i)/*values that are of a strict type, boolean, number, uint, string or int*/
                styleProperties.append(styleProperty)
            }
        }
        return styleProperties
    }
}
private class Utils{
    static var precedingWith:String = "(?<=\\,|^)"
    static var prefixGroup:String = "([\\w\\d\\s\\:\\#]*?)?"
    static var group:String = "(\\[[\\w\\s\\,\\.\\#\\:]*?\\])?"
    static var suffix:String = "([\\w\\d\\s\\:\\#]*?)?(?=\\,|$)"//the *? was recently changed from +?
    static var siblingPattern:String = precedingWith + prefixGroup + group + suffix/*this pattern is here so that its not recrated every time*/
    /**
     * Returns an array of style instances derived from PARAM: style (that has a name with 1 or more comma signs, or in combination with a group [])
     * PARAM: style: style.name has 1 or more comma seperated words
     * // :TODO: write a better description
     * // :TODO: optimize this function, we probably need to ousource the second loop in this function
     * // :TODO: using the words suffix and prefix is the wrong use of their meaning, use something els
     * // :TODO: add support for syntax like this: [Panel,Slider][Button,CheckBox]
     */
    class func siblingStyles(styleName:String,_ value:String)->Array<IStyle> {
        //Swift.print("CSSParser.siblingStyles(): " + "styleName: " + styleName)
        enum styleNameParts:Int{case prefix = 1, group, suffix}
        var sibblingStyles:Array<IStyle> = []
        let style:IStyle = CSSParser.style("", value)/*creates an empty style i guess?*/
        let matches = RegExp.matches(styleName,siblingPattern)// :TODO: /*use associate regexp here for identifying the group the subseeding name and if possible the preceding names*/
        //Swift.print("matches: " + "\(matches.count)")
        for match:NSTextCheckingResult in matches {
            if(match.numberOfRanges > 0){
                var prefix:String = match.value(styleName,1)
                prefix = prefix != "" ? RegExpModifier.removeWrappingWhitespace(prefix) : prefix;
                let group:String =  match.value(styleName,2)
                var suffix:String = match.value(styleName,3)
                suffix = suffix != "" ? RegExpModifier.removeWrappingWhitespace(suffix) : suffix
                if(group == "") {
                    sibblingStyles.append(StyleModifier.clone(style, suffix, SelectorParser.selectors(suffix)))
                }else{
                    let precedingWith:String = "(?<=\\[)"
                    let endingWith:String = "(?=\\])"
                    let bracketPattern:String = precedingWith + "[\\w\\s\\,\\.\\#\\:]*?" + endingWith
                    let namesInsideBrackets:String = RegExp.match(group, bracketPattern)[0]
                    let names:Array<String> = StringModifier.split(namesInsideBrackets, ",")
                    for name in names {
                        let condiditonalPrefix:String = prefix != "" ? prefix + " " : ""
                        let conditionalSuffix:String = suffix != "" ? " " + suffix : ""
                        let fullName:String =  condiditonalPrefix + name + conditionalSuffix
                        //Swift.print("fullName: " + fullName)
                        sibblingStyles.append(StyleModifier.clone(style, fullName, SelectorParser.selectors(fullName)))
                    }
                }
            }
        }
        return sibblingStyles
    }
}
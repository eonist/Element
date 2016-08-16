import Foundation
/**
 * TODO: rename this class to CSSPointerResolver? Since it can be confused with resolving css View container urls?
 * EXAMPLE: Swift.print(CSSLinkResolver.resolveLinks("Button{fill:<ButtonBase>;} ButtonBase{fill:green;line:blue;} CheckButton{line:<ButtonBase>;}"))//Button{fill:green;} ButtonBase{fill:green;line:blue;} CheckButton{line:blue;}
 */
class CSSLinkResolver {
    static let precedingWith:String = "(?<=\\;|^|\\{)"
    static let whiteSpace:String = "[\\n\\s\\t\\v\\r]*?"
    static let nameGroup:String = "([\\w \\,\\[\\]\\.\\#\\:\\-]+?)"
    static let valueGroup:String = "(.+?)(?=\\;)"
    static let linkPropertyPattern:String = precedingWith + whiteSpace + nameGroup + "\\:" + valueGroup
    static let sansBracketPattern:String = "(?<=<)[\\w \\:]+?(?=>)"
    enum CSSElementType:Int{ case name = 1, value}
    /**
     * Returns a CSS string with all css links resolved, a css link is where a key points to another key to obtain its value
     * NOTE: this method is recursive and traverses down through all its decendants. Think of a tree diagram
     * NOTE: also resolves the weight of each style and merges styles according to the CSS methodology
     * TODO: the replaceRange method may slow things down research a better replace method
     * EXAMPLE: resolveLinks("CustomButton{fill:yellow;} CustomButton:down{fill:green;}")//This is the log if you log the name and values: Name: fill, Value: yellow, Name: fill,Value: green
     * NOTE: you could also do a forward for loop and then offset the range as your traverse the matches
     */
    class func resolveLinks(var string:String)->String{
        let matches = RegExp.matches(string, linkPropertyPattern)
        matches.count
        for var i = matches.count-1; i > -1; --i{
            let match:NSTextCheckingResult = matches[i]
            //print(i)
            //Swift.print(match.numberOfRanges)
            let name = (string as NSString).substringWithRange(match.rangeAtIndex(CSSElementType.name.rawValue))//
            //Swift.print("Name: " + name)
            let value = (string as NSString).substringWithRange(match.rangeAtIndex(CSSElementType.value.rawValue))//
            //Swift.print("Value: " + value)
            let replacementString:String = Utils.replaceLinks(value,name,string)
            //Swift.print("Result: " + replacementString)
            let range:NSRange = match.rangeAtIndex(2)//the range of the value
            //Swift.print("CSSLinkResolver.resolveLinks() range: " + String(range))
            string = (string as NSString).stringByReplacingCharactersInRange(range, withString: replacementString)
        }
        return string
    }
}
private class Utils {
    /**
     * Replaces the value with the value from the key pointer
     * // :TODO: write an example
     * NOTE: there is no speed benefit of optimizing querrying for linkedStyleProperty
     * NOTE: the sansBracketPattern basically finds the content inside the "<" and the ">"
     * PARAM: cssString: is the original css string in its entirety (not a form of excerpt)
     * NOTE: you could also maybe loop backwards an replace that way, then you wouldnt have to store a new index
     */
    class func replaceLinks(var string:String,_ linkPropName:String,_ cssString:String)->String{
        //Swift.print("replaceLinks.string: " + string);
        let matches = RegExp.matches(string, CSSLinkResolver.sansBracketPattern)
        //Swift.print("replaceLinks()" + String(matches.count))
        //var index:Int = 0;
        var difference:Int = 0/*<--the diff from each replace, replace 4 char with 6 then diff is += 2 etc, replace less then substract*/
        for match:NSTextCheckingResult in matches {/*Loops through the pattern*/
            //Swift.print(match.numberOfRanges)
            if(match.numberOfRanges > 0){/*match = the link name>*/
                var range:NSRange = match.rangeAtIndex(0)//StringRangeParser.stringRange(string, start, end)
                range.location = range.location + difference
                let linkNameSansBrackets:String = (string as NSString).substringWithRange(range)/*the link name>*/
                let linkedStyleProperty:String = propertyValue(cssString,linkNameSansBrackets,linkPropName)/*replacementString*/
                range.location = range.location-1//add the < char
                range.length = range.length+2//add the > char
                difference += (linkedStyleProperty.count - range.length)
                string = (string as NSString).stringByReplacingCharactersInRange(range, withString: linkedStyleProperty)
            }
        }
        return string;
    }
    /**
     * Returns a style property value by parsing through PARAM: string and tries to find a match that matches both PARAM: linkName and PARAM: propertyName
     * PARAM: linkName the linkname is style name to search for
     * PARAM: propertyName is the property name for the property value to be returned
     * PARAM: string is the entire css document combined into 1 string
     * // :TODO: write an example
     * // :TODO: you can write a more precise expression to match the content of a style block
     */
    class func propertyValue(string:String,_ linkName:String,_ propertyName:String)->String{
        let pattern:String = "(?<=" + linkName + "\\{)(.|\\n)+?(?=\\})"
        //print("pattern: " + pattern);
        var match:Array = RegExp.match(string, pattern)
        //print("value.match: " + match[0]);
        if(match.count > 0){/*this try catch method is here so its easier to debug which linkName threw */
            let matchString:String =  match[0]
            return value(matchString,propertyName);
        }else{
            fatalError("no match found by linkName: " + linkName+" and propertyName: "+propertyName )
        }
    }
    /**
     * Returns a propertyValue from PARAM: str (a style block)
     * PARAM: string a style block
     * PARAM: propName the property name for the property value to be returned
     * write an example
     * // :TODO: you can write a more precise expression to match the content of a style block
     */
    class func value(string:String,_ propName:String)->String{
        let pattern:String = "(?<=" + propName + "\\:).+?(?=\\;)"
        var match:Array = RegExp.match(string, pattern)
        if(match.count > 0){/*this try catch method is here so its easier to debug which propName threw an error*/
            return match[0]
        }else{
            fatalError(" string:>"+string+"<"+" propName:>"+propName+"<")
        }
    }
}
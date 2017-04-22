import Foundation
@testable import Utils
/**
 * EXAMPLE: Swift.print(CSSLinkResolver.resolveLinks("Button{fill:<ButtonBase>;} ButtonBase{fill:green;line:blue;} CheckButton{line:<ButtonBase>;}"))//Button{fill:green;} ButtonBase{fill:green;line:blue;} CheckButton{line:blue;}
 * TODO: rename this class to CSSPointerResolver? Since it can be confused with resolving css View container urls?
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
     * NOTE: you could also do a forward for loop and then offset the range as your traverse the matches
     * TODO: the replaceRange method may slow things down research a better replace method
     * EXAMPLE: resolveLinks("CustomButton{fill:yellow;} CustomButton:down{fill:green;}")//This is the log if you log the name and values: Name: fill, Value: yellow, Name: fill,Value: green
     */
    static func resolveLinks(_ string:String)->String{
        var string = string
        let matches = RegExp.matches(string, linkPropertyPattern)
        //matches.count
        for i in (0..<matches.count).reversed(){//swift 3 update -> was: //for var i = matches.count-1; i > -1; --i{
            let match:NSTextCheckingResult = matches[i]
            let name = match.value(string, CSSElementType.name.rawValue)
            let value = match.value(string, CSSElementType.value.rawValue)
            let replacementString:String = Utils.replaceLinks(value,name,string)
            let range:NSRange = match.rangeAt(2)//the range of the value
            string = (string as NSString).replacingCharacters(in: range, with: replacementString)
        }
        return string
    }
}
private class Utils {
    /**
     * Replaces the value with the value from the key pointer
     * PARAM: cssString: is the original css string in its entirety (not a form of excerpt)
     * NOTE: there is no speed benefit of optimizing querrying for linkedStyleProperty
     * NOTE: the sansBracketPattern basically finds the content inside the "<" and the ">"
     * NOTE: you could also maybe loop backwards an replace that way, then you wouldnt have to store a new index
     * TODO: write an example
     */
    static func replaceLinks(_ string:String,_ linkPropName:String,_ cssString:String)->String{
        var string:String = string
        //Swift.print("replaceLinks.string: " + string);
        let matches = RegExp.matches(string, CSSLinkResolver.sansBracketPattern)
        //Swift.print("replaceLinks()" + String(matches.count))
        //var index:Int = 0
        var difference:Int = 0/*<--the diff from each replace, replace 4 char with 6 then diff is += 2 etc, replace less then substract*/
        for match:NSTextCheckingResult in matches {/*Loops through the pattern*/
            if(match.numberOfRanges > 0){/*match = the link name>*/
                var range:NSRange = match.rangeAt(0)//StringRangeParser.stringRange(string, start, end)
                range.location = range.location + difference
                let linkNameSansBrackets:String = (string as NSString).substring(with: range)/*the link name>*/
                let linkedStyleProperty:String = propertyValue(cssString,linkNameSansBrackets,linkPropName)/*replacementString*/
                range.location = range.location-1//add the < char
                range.length = range.length+2//add the > char
                difference += (linkedStyleProperty.count - range.length)
                string = (string as NSString).replacingCharacters(in: range, with: linkedStyleProperty)
            }
        }
        return string
    }
    /**
     * Returns a style property value by parsing through PARAM: string and tries to find a match that matches both PARAM: linkName and PARAM: propertyName
     * PARAM: linkName the linkname is style name to search for
     * PARAM: propertyName is the property name for the property value to be returned
     * PARAM: string is the entire css document combined into 1 string
     * TODO: write an example
     * TODO: you can write a more precise expression to match the content of a style block
     */
    static func propertyValue(_ string:String,_ linkName:String,_ propertyName:String)->String{
        let pattern:String = "(?<=" + linkName + "\\{)(.|\\n)+?(?=\\})"
        var match:[String] = RegExp.match(string, pattern)
        if(match.count > 0){/*this try catch method is here so its easier to debug which linkName threw */
            let matchString:String =  match[0]
            return value(matchString,propertyName)
        }else{
            fatalError("no match found for linkName: " + linkName+" with propertyName: " + propertyName )
        }
    }
    /**
     * Returns a propertyValue from PARAM: str (a style block)
     * PARAM: string a style block
     * PARAM: propName the property name for the property value to be returned
     * write an example
     * TODO: you can write a more precise expression to match the content of a style block
     */
    static func value(_ string:String,_ propName:String)->String{
        let pattern:String = "(?<=" + propName + "\\:).+?(?=\\;)"
        var match:Array = RegExp.match(string, pattern)
        if(match.count > 0){/*This try catch method is here so its easier to debug which propName threw an error*/
            return match[0]
        }else{
            fatalError(" string:>"+string+"<"+" propName:>"+propName+"<")
        }
    }
}

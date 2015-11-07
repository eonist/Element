import Foundation
class CSSParser{
    static var precedingWith:String = "(?<=^|\\})"
    static var nameGroup:String = "([\\w\\s\\,\\[\\]\\.\\#\\:]*?)"
    static var valueGroup:String = "((?:.|\\n)*?)"
    static var CSSElementPattern:String = precedingWith + nameGroup + "\\{" + valueGroup + "\\}"/*this pattern is here so that its not recrated every time*/
    enum CSSElementType:Int{ case name = 1, value}
    /**
     * Returns a StyleCollection populated with Style instances, by converting a css string and assigning each style to a Styleclass and then adding these to the StyleCollection
     * @param cssString: a string comprised by css data h1{color:blue;} etc
     * @return StyleCollection populated with Styles
     * @Note: We cant sanitize the cssString for whitespace becuase whitespace is needed to sepereate some variables (i.e: linear-gradient)
     */
    class func styleCollection(cssString:String){
        //Swift.print(CSSElementPattern)
        let matches = RegExp.matches(cssString, CSSElementPattern)
        //Swift.print(matches.count)
        
        for match:NSTextCheckingResult in matches {
            //Swift.print( match.numberOfRanges)
            var styleName:String = (cssString as NSString).substringWithRange(match.rangeAtIndex(1))//name
            //Swift.print("styleName: " + styleName)
            var value:String =  (cssString as NSString).substringWithRange(match.rangeAtIndex(2))//value
            //Swift.print("value: " + value)
            
            
            if(StringAsserter.contains(styleName, ",") == false){
                style(styleName,value)
            }
            else{
                Utils.siblingStyles(styleName, value)
            }
            
            //continue here, add the sibling code
        }
        
        
    }
    /**
     * Converts cssStyleString to a Style instance
     * Also transforms the values so that : (with Flash readable values, colors: become hex colors, boolean strings becomes real booleans etc)
     * @param name: the name of the style
     * @param value: a string comprised of a css style syntax (everything between { and } i.e: color:blue;border:true;)
     */
    class func style(var name:String,_ value:String){
        Swift.print("style()")
        name = RegExpModifier.removeWrappingWhitespace(name);/*removes space from left and right*/
        var pattern:String = "([\\w\\s\\,\\-]*?)\\:(.*?)\\;"
        let matches = RegExp.matches(value, pattern)
        for match:NSTextCheckingResult in matches {
            Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
            var propertyName:String = (value as NSString).substringWithRange(match.rangeAtIndex(1))//name
            Swift.print("propertyName: "+propertyName)
            var propertyValue:String = (value as NSString).substringWithRange(match.rangeAtIndex(2))//value
            Swift.print("propertyValue: "+propertyValue)
            
        }
        
    }
    /**
     *
     */
    class func styleProperties(propertyName:String, _ propertyValue:String){
        let names = StringAsserter.contains(propertyName, ",") ? StringModifier.split(propertyName, propertyValue) : [propertyName]
        for var name in names {
            name = RegExpModifier.removeWrappingWhitespace(name);
            var valExp:String = "\\w\\.\\-%#\\040<>\\/";/*expression for a single value*/
            var pattern:String = "(["+valExp+"]+?|["+valExp+"]+?\\(["+valExp+",]+?\\))(?=,|$)"
            var values:Array<String> = RegExp.match(propertyValue,pattern)
            for (var i : Int = 0; i < values.count; i++) {
                var value = values[i]
                value = RegExpModifier.removeWrappingWhitespace(value)
                Swift.print(" value: " + value)
            }
        }
    }
}
private class Utils{
    static var precedingWith:String = "(?<=\\,|^)"
    static var prefixGroup:String = "([\\w\\d\\s\\:\\#]*?)?"
    static var group:String = "(\\[[\\w\\s\\,\\.\\#\\:]*?\\])?"
    static var suffix:String = "([\\w\\d\\s\\:\\#]*?)?(?=\\,|$)"//the *? was recently changed from +?
    static var siblingPattern:String = precedingWith + prefixGroup + group + suffix
    class func siblingStyles(styleName:String,_ value:String)->Array<String> {
        Swift.print("siblingStyles(): " + "styleName: " + styleName)
        enum styleNameParts:Int{case prefix = 1, group, suffix}
        let sibblingStyles:Array<String> = []
        let matches = RegExp.matches(styleName,siblingPattern)
        Swift.print("matches: " + "\(matches.count)")
        for match:NSTextCheckingResult in matches {
            Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
            if(match.numberOfRanges > 0){
                //var theMatchString = (styleName as NSString).substringWithRange(match.rangeAtIndex(0))
                //Swift.print("theMatchString: " + theMatchString)
                var prefix:String = (styleName as NSString).substringWithRange(match.rangeAtIndex(1))
                Swift.print("prefix: " + prefix)
                prefix = prefix != "" ? RegExpModifier.removeWrappingWhitespace(prefix) : prefix;
                
                
                let group:String =  (styleName as NSString).substringWithRange(match.rangeAtIndex(2))
                Swift.print("group: " + group)
                
                Swift.print("match.rangeAtIndex(3): " + "\(match.rangeAtIndex(3))")
                
                var suffix:String = (styleName as NSString).substringWithRange(match.rangeAtIndex(3))
                Swift.print("suffix: " + suffix)
                
                suffix = suffix != "" ? RegExpModifier.removeWrappingWhitespace(suffix) : suffix;
                
                if(group == "") {
                    
                }else{
                    let precedingWith:String = "(?<=\\[)"
                    let endingWith:String = "(?=\\])"
                    let bracketPattern:String = precedingWith + "[\\w\\s\\,\\.\\#\\:]*?" + endingWith
                    let namesInsideBrackets:String = RegExp.match(group, bracketPattern)[0]
                    let names:Array<String> = StringModifier.split(namesInsideBrackets, ",")
                    for name in names {
                        let condiditonalPrefix:String = prefix != "" ? prefix + " " : "";
                        let conditionalSuffix:String = suffix != "" ? " " + suffix : "";
                        let fullName:String =  condiditonalPrefix + name + conditionalSuffix;
                        Swift.print("fullName: " + fullName)
                    }
                }
                /**/
            }
            //Swift.print( match.numberOfRanges)
            //
        }
        //styleName
        return sibblingStyles
    }
}
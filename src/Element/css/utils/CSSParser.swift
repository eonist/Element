import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ if you strip the inital css data for spaces then you won't need to removeWrappingWhiteSpace all the time
 */
class CSSParser{
    enum CSSElement {
        private static let precedingWith:String = "(?<=^|\\})"
        private static let nameGroup:String = "([\\w\\s\\,\\[\\]\\.\\#\\:]*?)"
        private static let valueGroup:String = "((?:.|\\n)*?)"
        static let pattern:String = precedingWith + nameGroup + "\\{" + valueGroup + "\\}"/*this pattern is here so that its not recrated every time*/
    }
    enum CSSStyle{
        static let pattern:String = "([\\w\\s\\,\\-]*?)\\:(.*?)\\;"
        enum Property{
            private static let value:String = "\\w\\.\\-%#\\040<>\\/~"/*expression for a single value, added the tilde char to support relative paths while in debug, could be usefull for production aswell*/
            static let values:String = "(["+value+"]+?|["+value+"]+?\\(["+value+",]+?\\))(?=,|$)"/*find each value that is seperated with the "," character (value can by itself contain commas, if so thous commas are somewhere within a "(" and a ")" character)*/
        }
    }
    enum CSSElementType:Int{case name = 1, value}
    /**
     * Returns a StyleCollection populated with Style instances, by converting a css string and assigning each style to a Styleclass and then adding these to the StyleCollection
     * RETURN: StyleCollection populated with Styles
     * PARAM: cssString: a string comprised by css data h1{color:blue;} etc
     * NOTE: We can't sanitize the cssString for whitespace becuase whitespace is needed to sepereate some variables (i.e: linear-gradient)
     * TODO: ⚠️️ Try to use lazy.map.reduce on the bellow
     */
    static func styleCollection(_ cssString:String)->IStyleCollection{
        let matches = RegExp.matches(cssString, CSSElement.pattern)/*Finds and seperates the name of the style and the content of the style*/// :TODO: name should be +? value also?;
        return matches.mapReduce(StyleCollection()) {/*Loops through the pattern*/
            var styleCollection:StyleCollection = $0
            let match:NSTextCheckingResult = $1
            let styleName:String = match.value(cssString, 1)/*name*/
            let value:String = match.value(cssString, 2)/*value*/
            if(StringAsserter.contains(styleName, ",")){/*Sibling styles*/
                let siblingStyles:[IStyle] = Utils.siblingStyles(styleName, value)
                styleCollection.addStyles(siblingStyles)/*If the styleName has multiple comma-seperated names*/
            }else{/*Single style*/
                let style:IStyle = CSSParser.style(styleName,value)
                styleCollection.addStyle(style)/*If the styleName has 1 name*/
            }
            return styleCollection
        }
    }
    /**
     * Converts cssStyleString to a Style instance
     * Also transforms the values so that : (with swift readable values, colors: become hex colors, boolean strings becomes real booleans etc)
     * PARAM: name: the name of the style
     * PARAM: value: a string comprised of a css style syntax (everything between { and } i.e: color:blue;border:true;)
     */
    static func style(_ name:String,_ value:String)->IStyle{
        let name = name != "" ? RegExpModifier.removeWrappingWhitespace(name) : ""/*removes space from left and right*/
        let selectors:[ISelector] = SelectorParser.selectors(name)
        let matches = value.matches(CSSStyle.pattern)
        let styleProps:[IStyleProperty] = matches.lazy.map{ match -> [IStyleProperty] in
            let propName:String = match.value(value, 1)/*name*/
            let propValue:String = match.value(value, 2)/*value*/
            return CSSParser.styleProperties(propName,propValue)
            }.reduce([]){
                return $0 + $1
        }
        return Style(name,selectors,styleProps)
    }
    /**
     * Returns an array of StyleProperty items (if a name is comma delimited it will create a new styleProperty instance for each match)
     * NOTE: now supports StyleProperty2 that can have many property values
     */
    static func styleProperties(_ propertyName:String, _ propertyValue:String) -> [IStyleProperty]{
        let names = propertyName.contains(",") ? propertyName.split(propertyValue) : [propertyName]//Converts a css property to a swift compliant property that can be read by the swift api
        return names.lazy.map { name -> [IStyleProperty] in
            let name:String = RegExpModifier.removeWrappingWhitespace(name)
            var values:[String] = propertyValue.match(CSSStyle.Property.values)
            return (0..<values.count).indices.map{ i -> IStyleProperty in
                let value = RegExpModifier.removeWrappingWhitespace(values[i])
                let propertyValue:Any = CSSPropertyParser.property(value)
                let styleProperty:IStyleProperty = StyleProperty(name,propertyValue,i)/*values that are of a strict type, boolean, number, uint, string or int*/
                return styleProperty
            }
        }.flatMap{$0}/*flattens 2 deep arr into 1 deep arr*/
    }
}
private class Utils{
    enum Sibling{
        static let precedingWith:String = "(?<=\\,|^)"
        static let prefixGroup:String = "([\\w\\d\\s\\:\\#]*?)?"
        static let group:String = "(\\[[\\w\\s\\,\\.\\#\\:]*?\\])?"
        static let suffix:String = "([\\w\\d\\s\\:\\#]*?)?(?=\\,|$)"//the *? was recently changed from +?
        static let pattern = precedingWith + prefixGroup + group + suffix/*this pattern is here so that its not recrated every time*/
    }
    enum Bracket {
        static let precedingWith:String = "(?<=\\[)"
        static let endingWith:String = "(?=\\])"
        static let pattern = precedingWith + "[\\w\\s\\,\\.\\#\\:]*?" + endingWith
    }
    enum styleNameParts:Int{case prefix = 1, group, suffix}
    /**
     * Returns an array of style instances derived from PARAM: style (that has a name with 1 or more comma signs, or in combination with a group [])
     * PARAM: style: style.name has 1 or more comma seperated words
     * TODO: write a better description
     * TODO: optimize this function, we probably need to outsource the second loop in this function
     * TODO: using the words suffix and prefix is the wrong use of their meaning, use something els
     * TODO: add support for syntax like this: [Panel,Slider][Button,CheckBox]
     * TODO: ⚠️️ You can use functional programming here 🤖: use lazy map and flatMap to flatten to 1 depth
     */
    static func siblingStyles(_ styleName:String,_ value:String)->[IStyle] {
        var siblingStyles:[IStyle] = []
        let style:IStyle = CSSParser.style("", value)/*creates an empty style i guess?*/
        let matches = styleName.matches(Sibling.pattern)/*TODO: Use associate regexp here for identifying the group the subseeding name and if possible the preceding names*/
        matches.forEach { match in
            if(match.numberOfRanges > 0){
                let prefix:String = {
                    let prefix = match.value(styleName,1)
                    return prefix != "" ? RegExpModifier.removeWrappingWhitespace(prefix):prefix
                }()
                let group:String =  match.value(styleName,2)
                let suffix:String = {
                    let suffix = match.value(styleName,3)
                    return suffix != "" ? RegExpModifier.removeWrappingWhitespace(suffix):suffix
                }()
                if(group == "") {
                    siblingStyles.append(StyleModifier.clone(style, suffix, SelectorParser.selectors(suffix)))
                }else{
                    let namesInsideBrackets:String = RegExp.match(group, Bracket.pattern)[0]
                    let names:[String] = StringModifier.split(namesInsideBrackets, ",")
                    names.forEach {  name in
                        let condiditonalPrefix:String = prefix != "" ? prefix + " " : ""
                        let conditionalSuffix:String = suffix != "" ? " " + suffix : ""
                        let fullName:String =  condiditonalPrefix + name + conditionalSuffix
                        siblingStyles.append(StyleModifier.clone(style, fullName, SelectorParser.selectors(fullName)))
                    }
                }
            }
        }
        return siblingStyles
    }
}

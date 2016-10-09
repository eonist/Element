import Foundation
/**
 * NOTE: it may be tempting to move this into CSSFIle class as an internal class since noone else uses this class but CSSFile is simpler to understand as a standalone class (Number of classes != ease of use)
 */
class CSSFileParser {
    /**
     * Returns a string containing css styles (including styles from imports and sub imports)
     * NOTE: this method is recursive
     * NOTE: this method also removes any comments (the reason it must be located within the recursive method is because comments may be among the import statements aswell)
     * NOTE: alternative method name: cssStringByURL
     * PARAM: url The url to load the css file from (must include the path + file-name + file-extension)
     * PARAM: cssString the recursive string passed down the hierarchy
     */
    static func cssString(url:String)->String {
        StyleManager.cssFileURLS.append(url)//<--new
        var string:String = FileParser.content(url.tildePath)!//TODO: you need to make a tilePath assert
        //cssString = string//temp fix until you implement the recusrive import stuff bellow
        //Swift.print("string: " + "\(string)")
        string = RegExpModifier.removeComments(string)
        let importsAndStyles = CSSFileParser.separateImportsAndStyles(string)
        //Swift.print("importsAndStyles.imports: " + "\(importsAndStyles.imports)")
        let importStrings:Array<String> = CSSFileParser.importStrings(importsAndStyles.imports)
        let path:String = StringParser.path(url)/*<--extracts the path and excludes the file-name and extension*/
        //Swift.print("path: " + "\(path)")
        var cssString:String = ""
        cssString += importsAndStyles.style/*<--Add the styles in the current css file*/
        for importString in importStrings{cssString += CSSFileParser.cssString(path + importString)}/*<--imports css from other css files*/// :TODO: make an if clause that makes sure it doesn't import it self like path+import != url
        
        return cssString
    }
    /**
     * Returns import urls in an array (only the path part)
     * NOTE: Supports both syntax styles: @import url("style.css") and @import "style.css"
     * NOTE: this function used to just be a one line match function but it seemd imposible to use match and be able to have the syntax url as an optional syntax
     * // :TODO: this can probably be written a little better
     * Example: CSSFileParser.importStrings("@import url(\"mainContent.css\");")//mainContent.css
     */
    static func importStrings(string:String)->Array<String> {
        var importStrings:Array<String> = []
        let pattern:String = "(?:@import (?:url)?\\(\")(.*?)(?=\"\\)\\;)"/*assigns the name and value to an object (Associative) // :TODO: (the dot in the end part could possibly be replaced by [.^\;] test this)*/
        let matches = RegExp.matches(string, pattern)
        matches.forEach {
            let url = $0.value(string, 1)//capturing group 1
            importStrings.append(url)
        }
        return importStrings
    }
    /**
     * Returns an Object with an import property and a style property from PARAM: cssString
     * NOTE: comments are removed before this method is called so no need for comments code here
     * NOTE: supports cssString that has only import or style or both
     * Example: "@import url(\"mainContent.css\");"
     */
    static func separateImportsAndStyles(cssString:String)->(imports:String,style:String){// :TODO: rename to filter or split maybe?
        //was: \\d\\s\\w\\W\\{\\}\\:\\;\\n\\%\\-\\.~\\/\\*
        let styleCharSet:String = "[^$]"//all possible chars that can be found in a stylesheet, except the end. the capture all dot variable didnt work so this is the alternate wway of doing it
        var pattern:String = "^"
        pattern += "("
        pattern +=      "[@\\(\\)\\w\\s\\.\\/\";\\n]*?"//importChars
        pattern +=      "(?="
        pattern +=          "(?:"
        pattern +=              "\\n[\\w\\s\\[\\]\\,\\#\\:\\.]+?\\{"
        pattern +=          ")|$"
        pattern +=      ")"
        pattern +=  ")?"
        pattern +=  "(" + styleCharSet + "+?$)?"
        //Swift.print("pattern: " + "\(pattern)")
        var result:(imports:String,style:String) = ("","")
        let matches = RegExp.matches(cssString, pattern)
        for match:NSTextCheckingResult in matches {
            //Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
            //for var i = 0; i < match.numberOfRanges; ++i{
                //Swift.print("loc: " + "\(match.rangeAtIndex(i).location)" + " length: " + "\(match.rangeAtIndex(i).length)")
            //}
            //let content = (cssString as NSString).substringWithRange(match.rangeAtIndex(0))//the entire match
            //Swift.print("content: " + "\(content)")
            result.imports = match.rangeAtIndex(1).length > 0 ? match.value(cssString, 1) : ""//capturing group 1
            result.style = match.rangeAtIndex(2).length > 0 ? match.value(cssString, 2) : ""//capturing group 2
        }
        return result
    }
}
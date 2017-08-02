import Foundation
@testable import Utils
/**
 * NOTE: it may be tempting to move this into CSSFIle class as an internal class since noone else uses this class but CSSFile is simpler to understand as a standalone class (Number of classes != ease of use)
 */
class CSSFileParser {
    enum Pattern{
        /**
         * //was: \\d\\s\\w\\W\\{\\}\\:\\;\\n\\%\\-\\.~\\/\\*
         */
        static let styleImportSeperation:String = {
            let styleCharSet:String = "[^$]"//all possible chars that can be found in a stylesheet, except the end. the capture all dot variable didnt work so this is the alternate wway of doing it
            var pattern:String = ""
            pattern += "^"
            pattern += "("
            pattern +=      "[@\\(\\)\\w\\s\\.\\/\";\\n]*?"//importChars
            pattern +=      "(?="
            pattern +=          "(?:"
            pattern +=              "\\n[\\w\\s\\[\\]\\,\\#\\:\\.]+?\\{"
            pattern +=          ")|$"
            pattern +=      ")"
            pattern +=  ")?"
            pattern +=  "(" + styleCharSet + "+?$)?"
            return pattern
        }()
        static let importString:String = "(?:@import (?:url)?\\(\")(.*?)(?=\"\\)\\;)"/*assigns the name and value to an object (Associative)  :TODO: (the dot in the end part could possibly be replaced by [.^\;] test this)*/
    }
    /**
     * Returns a string containing css styles (including styles from imports and sub imports)
     * NOTE: this method is recursive
     * NOTE: this method also removes any comments (the reason it must be located within the recursive method is because comments may be among the import statements aswell)
     * NOTE: alternative method name: cssStringByURL
     * PARAM: url: The url to load the css file from (must include the path + file-name + file-extension)
     * PARAM: cssString the recursive string passed down the hierarchy
     * TODO: ⚠️️ Make an if clause that makes sure it doesn't import it self like path+import != url
     Æ TODO: ⚠️️ Rename to expandHierarchy?
     */
    static func cssString(_ url:String) -> String {
        StyleManager.cssFileURLS.append(url.tildify)//<--new
        guard let content:String = FileParser.content(url.tildePath) else{fatalError("No file at: \(url)")}//TODO: you need to make a tilePath assert
        let string:String = RegExpModifier.removeComments(content)
        let importsAndStyles = CSSFileParser.importsAndStyles(string)
        let importStrings:[String] = CSSFileParser.importStrings(importsAndStyles.imports)
        let path:String = StringParser.path(url)/*<--extracts the path and excludes the file-name and extension*/
        let cssString:String = importStrings.reduce(""){ cssString, importString in
            cssString + CSSFileParser.cssString(path + importString)/*<--imports css from other css files*/
        }
        return cssString + importsAndStyles.style/*<--Add the styles in the current css file*/
    }
    /**
     * Returns import urls in an array (only the path part)
     * NOTE: Supports both syntax styles: @import url("style.css") and @import "style.css"
     * NOTE: this function used to just be a one line match function but it seemd imposible to use match and be able to have the syntax url as an optional syntax
     * TODO: ⚠️️ this can probably be written a little better
     * Example: CSSFileParser.importStrings("@import url(\"mainContent.css\");")//mainContent.css
     */
    static func importStrings(_ string:String)->[String]{
        return string.matches(Pattern.importString).map {$0.value(string, 1)}/*capturing group 1*/
    }
    /**
     * Returns an Object with an import property and a style property from PARAM: cssString
     * NOTE: comments are removed before this method is called so no need for comments code here
     * NOTE: supports cssString that has only import or style or both
     * Example: "@import url(\"mainContent.css\");"
     */
    static func importsAndStyles(_ cssString:String)->(imports:String,style:String){
        let matches = cssString.matches(Pattern.styleImportSeperation)
        if let match = matches[safe:0] {
            let imports:String = match.rangeAt(1).length > 0 ? match.value(cssString, 1) : ""/*capturing group 1*/
            let style:String = match.rangeAt(2).length > 0 ? match.value(cssString, 2) : ""/*capturing group 2*/
            return (imports,style)
        };return ("","")/*else*/
    }
}


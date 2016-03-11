import Foundation
/**
 * @Note it may be tempting to move this into CSSFIle class as an internal class since noone else uses this class but CSSFile is simpler to understand as a standalone class (Number of classes != ease of use)
 */
class CSSFileParser {
    /**
    * Returns a string containing css styles (including styles from imports and sub imports)
    * @Note this method is recursive
    * @Note this method also removes any comments (the reason it must be located within the recursive method is because comments may be among the import statements aswell)
    * @Note alternative method name: cssStringByURL
    * @param url The url to load the css file from
    * @param cssString the recursive string passed down the hierarchy
    */
    class func cssString(url:String)->String {
        var cssString:String = "";
        var string:String = FileParser.content(url.tildePath)!//TODO: you need to make a tilePath assert
        //cssString = string//temp fix until you implement the recusrive import stuff bellow
        //Swift.print("string: " + "\(string)");
        string = RegExpModifier.removeComments(cssString);
        //var importsAndStyles:Object = CSSFileParser.separateImportsAndStyles(string);
        //var importStrings:Array = CSSFileParser.importStrings(importsAndStyles["import"]);
        //var path:String = StringParser.path(url);
        //for each (var importString : String in importStrings) cssString += CSSFileParser.cssString(path+importString);// :TODO: make an if clause tha makes sure it doesnt import it self like path+import != url
        //cssString += importsAndStyles["style"];
        return cssString
    }
    /**
     * Returns import urls in an array (only the path part)
     * @Note Supports both syntax styles: @import url("style.css") and @import "style.css"
     * @Note this function used to just be a one line match function but it seemd imposible to use match and be able to have the syntax url as an optional syntax
     * // :TODO: this can probably be written a little better
     * Example: CSSFileParser.importStrings("@import url(\"mainContent.css\");")//mainContent.css
     */
    class func importStrings(string:String)->Array<String> {
        var importStrings:Array<String> = [];
        let pattern:String = "(?:@import (?:url)?\\(\")(.*?)(?=\"\\)\\;)"//assigns the name and value to an object (Associative) // :TODO: (the dot in the end part could possibly be replaced by [.^\;] test this)
        let matches = RegExp.matches(string, pattern)
        for match:NSTextCheckingResult in matches {
            let url = (string as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
            importStrings.append(url)
        }
        return importStrings;
    }
    /**
     * Returns an Object with an import property and a style property from @param cssString
     * @Note comments are removed before this method is called so no need for comments code here
     * @Note supports cssString that has only import or style or both
     */
    class func separateImportsAndStyles(cssString:String)->(imports:String,style:String){// :TODO: rename to filter or split maybe?
        //^(?P<import>[@\(\)\w\040\.\/";\n]*?(?=(\n[\w\040\[\]\,\#\:\.]+?\{)|$))?(?P<style>.+?$)?
        let pattern:String = "[@\\(\\)\\w\\040\\.\\/\"\\;\n]*?"
        "[\\w\\040\\[\\]\\,\\#\\:\\.]"
        var matches:Object = cssString.match(//s);
        //			trace("matchs: " + matchs);
        //			if(matches != null){
        //				trace("import: " + matches["import"]);
        //				trace("style: " + matches["style"]);
        //			}
        return matches;
    }
}

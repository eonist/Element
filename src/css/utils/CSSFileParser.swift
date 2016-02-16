import Foundation

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
        let string:String = FileParser.content(url.tildePath)!//TODO: you need to make a tilePath assert
        cssString = string//temp fix until you implement the recusrive import stuff bellow
        //Swift.print("string: " + "\(string)");
        //string = StringModifier.removeComments(string);
        //var importsAndStyles:Object = CSSFileParser.separateImportsAndStyles(string);
        //var importStrings:Array = CSSFileParser.importStrings(importsAndStyles["import"]);
        //var path:String = StringParser.path(url);
        //for each (var importString : String in importStrings) cssString += CSSFileParser.cssString(path+importString);// :TODO: make an if clause tha makes sure it doesnt import it self like path+import != url
        //cssString += importsAndStyles["style"];
        return cssString
    }
}

import Foundation

class StyleCollectionParser {
    /**
     * Describes the stylecollection content
     * Note can you use the ObjectDescriber in place of this class?
     */
    class func describe(styleCollection:IStyleCollection) {
        func printStyleProperties(style:IStyle) {
            Swift.print("printStyleProperties <style.name>:"+style.name);
            var propertyNames:Array = StyleParser.stylePropertyNames(style);
            let propertyLength:Int = style.styleProperties.count;
            for (var e : Int = 0; e < propertyLength; e++) {
                let property:Any = style.getValueAt(e);
                let name:String = propertyNames[e];
                Swift.print("name:" + name + ", property: " +  String(property));
            }
        }
        let stylesLength:Int = styleCollection.styles.count;
        for (var i : Int = 0; i < stylesLength; i++) {
            let style:IStyle = styleCollection.styles[i];
            printStyleProperties(style);
        }
    }
}
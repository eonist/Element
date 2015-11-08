import Foundation

class StyleCollectionDescriber {
    /**
    * Describes the stylecollection content
    * Note can you use the ObjectDescriber in place of this class?
    */
    class func describe(styleCollection:IStyleCollection) {
        var stylesLength:Int = styleCollection.styles.count;
        for (var i : Int = 0; i < stylesLength; i++) {
            var style:IStyle = styleCollection.styles[i];
            printStyleProperties(style);
        }
        func printStyleProperties(style:IStyle) {
            Swift.print("printStyleProperties <style.name>:"+style.name);
            var propertyNames:Array = StyleParser.stylePropertyNames(style);
            var propertyLength:Int = style.styleProperties.count;
            for (var e : Int = 0; e < propertyLength; e++) {
                var property:Any = style.getValueAt(e);
                var name:String = propertyNames[e];
                trace("name:" + name + ", property: " +  property);
            }
        }
    }
}
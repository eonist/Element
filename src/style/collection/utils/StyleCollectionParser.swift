import Foundation

class StyleCollectionParser {
    /**
     * Returns an array of style names
     */
    static func styleNames(styleCollection:IStyleCollection) -> Array<String>{
        var styleNames:Array<String> = []
        let numOfStyles:Int = styleCollection.styles.count/*<--CPU-optimization*/
        for (var i : Int = 0;i < numOfStyles; i++) {styleNames.append(styleCollection.styles[i].name)}
        return styleNames
    }
    /**
     * Describes the stylecollection content
     * Note can you use the ObjectDescriber in place of this class?
     */
    static func describe(styleCollection:IStyleCollection) {
        func printStyleProperties(style:IStyle) {
            //Swift.print("printStyleProperties:")
            Swift.print("<style.name>:"+style.name)
            var propertyNames:Array = StyleParser.stylePropertyNames(style);
            for e in 0..<style.styleProperties.count//<--swift 3 for loop upgrade
                let property:Any = style.getValueAt(e)
                let name:String = propertyNames[e]
                Swift.print("name:" + name + ", property: " +  String(property))
            }
        }
        for i in 0..<styleCollection.styles.count//<--swift 3 for loop upgrade
            let style:IStyle = styleCollection.styles[i]
            printStyleProperties(style)
        }
    }
}
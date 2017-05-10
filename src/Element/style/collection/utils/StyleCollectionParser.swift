import Foundation
/*@testable import Utils*/

class StyleCollectionParser {
    /**
     * Returns an array of style names
     */
    static func styleNames(_ styleCollection:IStyleCollection) -> [String]{
        return (0..<styleCollection.styles.count).indices.map{ i in
            return styleCollection.styles[i].name
        }
    }
    /**
     * Describes the stylecollection content
     * Note can you use the ObjectDescriber in place of this class?
     */
    static func describe(_ styleCollection:IStyleCollection) {
        func printStyleProperties(_ style:IStyle) {
            Swift.print("<style.name>:"+style.name)
            var propertyNames:[String] = StyleParser.stylePropertyNames(style)
            (0..<style.styleProperties.count).indices.forEach{ e in
                let property:Any = style.getValueAt(e)
                let name:String = propertyNames[e]
                Swift.print("name:" + name + ", property: " +  String(describing: property))
            }
        }
        styleCollection.styles.forEach { style in
            printStyleProperties(style)
        }
    }
}

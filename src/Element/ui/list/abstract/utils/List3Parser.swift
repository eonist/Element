import Cocoa
import Utils

class List3Parser {
    /**
     * Returns the index of a "label"
     * PARAM: view is the Label
     */
    static func index(_ list: Listable3, _ view:NSView)->Int {
        return list.contentContainer.indexOf(view)
    }
    /**
     * Returns the property for index
     */
    static func propertyAt(_ list:Listable3, _ index:Int)->String{
        return list.db.getItemAt(index)!["property"]!
    }
}

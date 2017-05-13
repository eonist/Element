import Cocoa
import Utils

class List3Parser {
    /**
     * Returns the index of a "label"
     * PARAM: view is the Label
     */
    static func index(_ list: Listable3, _ view:NSView)->Int {
        fatalError("out of order atm")
        //return list.contentContainer.indexOf(view)
    }
    /**
     * Returns the property for index
     */
    static func propertyAt(_ list:Listable3, _ index:Int)->String{
        fatalError("out of order atm")
        //return list.dp.getItemAt(index)!["property"]!
    }
}

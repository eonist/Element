import Foundation

class List3Parser {
    /**
     * Returns the index of a "label"
     * PARAM: view is the Label
     */
    static func index(_ list: Listable3, _ view:NSView)->Int {
        return list.lableContainer!.indexOf(view)
    }
}

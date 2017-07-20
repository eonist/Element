import Foundation
/**
 * NOTE: The StyleProperty instances are stored in _styleProperties, and then you querry them by name and depth
 */
struct Style:Stylable{
    var name:String/*Name of the class*/
    var selectors:[SelectorKind]/*[Type#id:state.class]*/
    var styleProperties:[StylePropertyKind]/*The styleProperties of this style*/
    init(_ name:String = "",_ selectors:[SelectorKind] = [], _ styleProperties:[StylePropertyKind] = []){
        self.name = name
        self.selectors = selectors
        self.styleProperties = styleProperties
    }
}

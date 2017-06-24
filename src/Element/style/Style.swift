import Foundation
/**
 * NOTE: The StyleProperty instances are stored in _styleProperties, and then you querry them by name and depth
 */
struct Style:IStyle{
    var name:String/*Name of the class*/
    var selectors:[ISelector]/*[Type#id:state.class]*/
    var styleProperties:[IStyleProperty]/*The styleProperties of this style*/
    init(_ name:String = "",_ selectors:[ISelector] = [], _ styleProperties:[IStyleProperty] = []){
        self.name = name
        self.selectors = selectors
        self.styleProperties = styleProperties
    }
}

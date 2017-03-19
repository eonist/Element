import Foundation
/**
 * NOTE: The StyleProperty instances are stored in _styleProperties, and then you querry them by name and depth
 * TODO: You could probably add most of these methods to an extension, since nothing is subclassing this class, ⚠️️ weightedStyle overrides style i think, you could jsut make a decorator WeigthedStyle i think, then this could be a struct!
 */
class Style:IStyle{
    var name:String
    var selectors:[ISelector]
    var styleProperties:[IStyleProperty]
    init(_ name:String = "",_ selectors:[ISelector] = [], _ styleProperties:[IStyleProperty] = []){
        self.name = name
        self.selectors = selectors
        self.styleProperties = styleProperties
    }
}
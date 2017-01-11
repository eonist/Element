import Foundation
/**
 * NOTE: The StyleProperty instances are stored in _styleProperties, and then you querry them by name and depth
 * TODO: I think you need to move some of these methods into parsers and modifiers, this class is cognativly heavy to look at
 * TODO: You could probably add most of these methods to an extension, since nothing is subclassing this class
 */
class Style:IStyle{
    var name:String
    var selectors:Array<ISelector>
    var styleProperties:Array<IStyleProperty>
    init(_ name:String = "",_ selectors:Array<ISelector> = [], _ styleProperties:Array<IStyleProperty> = []){
        self.name = name
        self.selectors = selectors
        self.styleProperties = styleProperties
    }
}
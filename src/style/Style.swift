import Foundation
/**
 * @Note the StyleProperty instances are stored in _styleProperties, and then you querry them by name and depth
 * // :TODO: I think you need to move some of these methods into parsers and modifiers, this class is cognativly heavy to look at
 * TODO: you could probably add most of these methods to an extension, since nothing is subclassing this class
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
extension Style{
    static var clear:IStyle = Style("clear",[],[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])//this won't work since it doesnt have any selectors
    /**
     * Adds styleProperties
     */
    func addStyleProperties(styleProperties:Array<IStyleProperty>){
        for styleProperty in styleProperties { addStyleProperty(styleProperty) }
    }
    /**
     * Add styleProperty
     * @Note will throw an error if a styleProperty with the same name is allready added
     * @Note the reason that the following methods are not moved into StyleModifier is because they arent that complex, a minimal set of core methods are ok in a bean style class like this, more advance methods can go into StyleModifier
     * // :TODO: but this method is cognativly taxing just look how long it is, makes more sense to move it to a modifier class, only simple methods should be in Type classes
     */
    func addStyleProperty(styleProperty:IStyleProperty) {
        styleProperties.append(styleProperty)//TODO:this method is more elaborate, it checks if the item is original, if its not throw error, implement this when its time
    }
    /**
     * Adds styleProperties
     */
    func addStyleProperty(styleProperties:Array<IStyleProperty>){
        for styleProperty : IStyleProperty in styleProperties{addStyleProperty(styleProperty) }
    }
    /**
     * @return a style property by the name given
     * @Note returning null is fine, no need to make a EmptyStyleProperty class, or is there?
     */
    func getStyleProperty(name:String,_ depth:Int = 0)->IStyleProperty?{
        //Swift.print("styleProperties.count: " + "\(styleProperties.count)")
        for styleProperty : IStyleProperty in styleProperties {
            //Swift.print("styleProperty.name: " + "\(styleProperty.name)" + " depth: " + "\(styleProperty.depth)")
            if(styleProperty.name == name && styleProperty.depth == depth){
                return styleProperty
            }
        }
        return nil
    }
    /**
     * NOTE: StyleParser.depthCount() uses this method
     */
    func getStyleProperties(name:String)->Array<IStyleProperty>{
        var styleProperties:Array<IStyleProperty> = []
        for styleProperty : IStyleProperty in self.styleProperties{if(styleProperty.name == name) {styleProperties.append(styleProperty)}}
        return styleProperties
    }
    /**
     * @Note a benefit of having this method is that when used you can use the interface of the return type instantly
     */
    func getStylePropertyAt(index:Int)->IStyleProperty{
        return styleProperties[index]
    }
    /**
     * @Note this function is not redundant, its usefull for qucik access in some methods
     */
    func getValue(name:String,_ depth:Int = 0)->Any?{
        var styleProperty:IStyleProperty? = getStyleProperty(name,depth)
        return styleProperty != nil ? styleProperty?.value : nil
    }
    /**
     * @Note this method is here for convenience (methods that should be contained in an Utils class are thous that are seldom used)
     */
    func getValueAt(index:Int)->Any{
        return getStylePropertyAt(index).value
    }
    
}
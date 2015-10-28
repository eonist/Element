import Foundation

class Style:IStyle{
    static var clear:IStyle = Style("clear",[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])
    var name:String;
    var styleProperties:Array<IStyleProperty>
    var selector:ISelector
    init(_ name:String, _ styleProperties:Array<IStyleProperty> = [],_ selector:ISelector = Selector()){
        self.name = name
        self.styleProperties = styleProperties
        self.selector = selector
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
    func getStyleProperty(name:String)->IStyleProperty?{
        for styleProperty : IStyleProperty in styleProperties {
            if(styleProperty.name == name){
                return styleProperty;
            }
        }
        return nil;
    }
}
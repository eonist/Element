import Foundation

extension IStyle{
    /**
     * Convenience method since apple doesn't support default values in protocols
     * NOTE: Default argument not permitted in a protocol method
     */
    /*func getStyleProperty(_ name:String,_ depth:Int = 0)->IStyleProperty?{
        return getStyleProperty(name, depth)
     }*/
    /**
     * Returns a style property by the name given
     * NOTE: returning nil is fine, no need to make a EmptyStyleProperty class, or is there?
     */
    func getStyleProperty(_ name:String,_ depth:Int = 0)->IStyleProperty?{
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
     * Convenience method since apple doesnt support default values in protocols
     * NOTE: Default argument not permitted in a protocol method
     */
    /*func getValue(_ name:String,_ depth:Int = 0)->Any?{
        return getValue(name, depth)
     }*/
    /**
     * NOTE: this function is not redundant, its usefull for qucik access in some methods
     */
    func getValue(_ name:String,_ depth:Int = 0)->Any?{
        var styleProperty:IStyleProperty? = getStyleProperty(name,depth)
        return styleProperty != nil ? styleProperty?.value : nil
    }
    func describe(){
        StyleParser.describe(self)
    }
    /**
     * Adds styleProperties
     */
    func addStyleProperties(_ styleProperties:[IStyleProperty]){
        for styleProperty in styleProperties {
            addStyleProperty(styleProperty)
        }
    }
    /**
     * Add styleProperty
     * NOTE: will throw an error if a styleProperty with the same name is allready added
     * NOTE: the reason that the following methods are not moved into StyleModifier is because they arent that complex, a minimal set of core methods are ok in a bean style class like this, more advance methods can go into StyleModifier
     * TODO: but this method is cognativly taxing just look how long it is, makes more sense to move it to a modifier class, only simple methods should be in Type classes
     */
    mutating func addStyleProperty(_ styleProperty:IStyleProperty) {
        styleProperties.append(styleProperty)//TODO:this method is more elaborate, it checks if the item is original, if its not throw error, implement this when its time
    }
    /**
     * Adds styleProperties
     */
    func addStyleProperty(_ styleProperties:[IStyleProperty]){
        for styleProperty:IStyleProperty in styleProperties{
            addStyleProperty(styleProperty)
        }
    }
    /**
     * NOTE: StyleParser.depthCount() uses this method
     */
    func getStyleProperties(_ name:String)->[IStyleProperty]{
        var styleProperties:[IStyleProperty] = []
        for styleProperty : IStyleProperty in self.styleProperties{if(styleProperty.name == name) {styleProperties.append(styleProperty)}}
        return styleProperties
    }
    /**
     * NOTE: a benefit of having this method is that when used you can use the interface of the return type instantly
     */
    func getStylePropertyAt(_ index:Int)->IStyleProperty{
        return styleProperties[index]
    }
    
    /**
     * NOTE: this method is here for convenience (methods that should be contained in an Utils class are thous that are seldom used)
     */
    func getValueAt(_ index:Int)->Any{
        return getStylePropertyAt(index).value
    }
}

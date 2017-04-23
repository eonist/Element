import Foundation

extension IStyle{
    /**
     * Returns a style property by the name given
     * NOTE: returning nil is fine, no need to make a EmptyStyleProperty class, or is there?
     */
    func getStyleProperty(_ name:String,_ depth:Int = 0)->IStyleProperty?{
        return styleProperties.first(where: {$0.name == name && $0.depth == depth})
    }
    /**
     * NOTE: this function is not redundant, it's usefull for qucik access in some methods
     */
    func getValue(_ name:String,_ depth:Int = 0)->Any?{
        return getStyleProperty(name,depth)?.value
    }
    /**
     * Add styleProperty
     */
    mutating func addStyleProperty(_ styleProperty:IStyleProperty) {
        styleProperties.append(styleProperty)//TODO:this method is more elaborate, it checks if the item is original, if its not throw error, implement this when its time
    }
    /**
     * Adds styleProperties
     */
    mutating func addStyleProperty(_ styleProperties:[IStyleProperty]){
        self.styleProperties = styleProperties.map{$0}
    }
    /**
     * NOTE: StyleParser.depthCount() uses this method
     */
    func getStyleProperties(_ name:String)->[IStyleProperty]{
        return self.styleProperties.filter(){ styleProperty in
            styleProperty.name == name
        }
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
    func describe(){
        StyleParser.describe(self)
    }
}


/**
 * Adds styleProperties
 */
/*func addStyleProperties(_ styleProperties:[IStyleProperty]){
 for styleProperty in styleProperties {
 addStyleProperty(styleProperty)
 }
 }*/

/**
 * Convenience method since apple doesnt support default values in protocols
 * NOTE: Default argument not permitted in a protocol method
 */
/*func getValue(_ name:String,_ depth:Int = 0)->Any?{
 return getValue(name, depth)
 }*/


/**
 * Convenience method since apple doesn't support default values in protocols
 * NOTE: Default argument not permitted in a protocol method
 */
/*func getStyleProperty(_ name:String,_ depth:Int = 0)->IStyleProperty?{
 return getStyleProperty(name, depth)
 }*/

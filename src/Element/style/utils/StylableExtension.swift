import Foundation
/**
 * TODO: ⚠️️ Add subScripts to get prop
 */
extension Stylable{
    /**
     * Returns a style property by the name given
     * NOTE: returning nil is fine, no need to make a EmptyStyleProperty class, or is there?
     */
    func getStyleProperty(_ stylePropName:String,_ depth:Int = 0)->StylePropertyKind?{
        return styleProperties.first(where: {$0.name == stylePropName && $0.depth == depth})
    }
    /**
     * NOTE: this function is not redundant, it's usefull for qucik access in some methods
     */
    func getValue(_ stylePropName:String,_ depth:Int = 0) -> Any?{
        return getStyleProperty(stylePropName,depth)?.value
    }
    /**
     * Add styleProperty
     */
    mutating func addStyleProperty(_ styleProperty:StylePropertyKind) {
        styleProperties.append(styleProperty)//TODO: ⚠️️ this method was more elaborate, it checks if the item is original, if its not throw error, implement this when its time
    }
    /**
     * Adds styleProperties
     */
    mutating func addStyleProperty(_ styleProperties:[StylePropertyKind]){
        self.styleProperties = styleProperties.map{$0}
    }
    /**
     * NOTE: StyleParser.depthCount() uses this method
     */
    func getStyleProperties(_ name:String)->[StylePropertyKind]{
        return self.styleProperties.filter(){ styleProperty in
            styleProperty.name == name
        }
    }
    /**
     * NOTE: a benefit of having this method is that when used you can use the interface of the return type instantly
     */
    func getStylePropertyAt(_ index:Int)->StylePropertyKind{
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
    var clone:Stylable {
        return StyleModifier.clone(self)
    }
}

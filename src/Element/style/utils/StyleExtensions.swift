import Foundation
@testable import Utils

extension Style{
    static var clear:IStyle = Style("clear",[],[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])//this won't work since it doesnt have any selectors
    /**
    * Adds styleProperties
    */
    func addStyleProperties(_ styleProperties:Array<IStyleProperty>){
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
    func addStyleProperty(_ styleProperty:IStyleProperty) {
        styleProperties.append(styleProperty)//TODO:this method is more elaborate, it checks if the item is original, if its not throw error, implement this when its time
    }
    /**
     * Adds styleProperties
     */
    func addStyleProperty(_ styleProperties:Array<IStyleProperty>){
        for styleProperty:IStyleProperty in styleProperties{
            addStyleProperty(styleProperty)
        }
    }
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
     * NOTE: StyleParser.depthCount() uses this method
     */
    func getStyleProperties(_ name:String)->Array<IStyleProperty>{
        var styleProperties:Array<IStyleProperty> = []
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
     * NOTE: this function is not redundant, its usefull for qucik access in some methods
     */
    func getValue(_ name:String,_ depth:Int = 0)->Any?{
        var styleProperty:IStyleProperty? = getStyleProperty(name,depth)
        return styleProperty != nil ? styleProperty?.value : nil
    }
    /**
     * NOTE: this method is here for convenience (methods that should be contained in an Utils class are thous that are seldom used)
     */
    func getValueAt(_ index:Int)->Any{
        return getStylePropertyAt(index).value
    }
    convenience init(_ id:String,_ styleProperty:IStyleProperty){/*Convenience*/
        self.init(id,[],[styleProperty])
    }
}

extension Style:UnWrappable{
    /**
     * Converts xml to a Style instance
     * IMPORTANT: this must be located here because it belongs in the Element lib but uses the swift-utils lib
     */
    static func unWrap<T>(_ xml:XML) -> T? {
        //Swift.print("xml.xmlString: " + "\(xml.xmlString)")
        let name:String = unWrap(xml, "name")!
        //Swift.print("UnWrap.name: " + "\(name)")
        let styleProperties:[StyleProperty?] = unWrap(xml, "styleProperties")
        //Swift.print("styleProperties.count: " + "\(styleProperties.count)")
        let selectors:[Selector?] = unWrap(xml, "selectors")
        //Swift.print("selectors.count: " + "\(selectors.count)")
        return Style(name,selectors.flatMap{$0},styleProperties.flatMap{$0}) as? T
    }
}

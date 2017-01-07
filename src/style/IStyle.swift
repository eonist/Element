import Foundation

protocol IStyle {
    /*Getters / Setters*/
    var name:String {get}
    var selectors:Array<ISelector> {get}
    var styleProperties:Array<IStyleProperty> {get set}
    /*Core methods*/
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
    func addStyleProperties(styleProperties:Array<IStyleProperty>)
    /*Implicit getters / setters*/
    func getStyleProperty(name:String,_ depth:Int)->IStyleProperty?
    func getValueAt(index:Int)->Any
    func getValue(name:String,_ depth:Int)->Any?
    func getStyleProperties(name:String)->Array<IStyleProperty>
    func getStylePropertyAt(index:Int)->IStyleProperty
}
extension IStyle{
    /**
     * Convenience method since apple doesn't support default values in protocols
     * NOTE: Default argument not permitted in a protocol method
     */
    func getStyleProperty(name:String,_ depth:Int = 0)->IStyleProperty?{
        return getStyleProperty(name, depth)
    }
    /**
     * Convenience method since apple doesnt support default values in protocols
     * NOTE: Default argument not permitted in a protocol method
     */
    func getValue(name:String,_ depth:Int = 0)->Any?{
        return getValue(name, depth)
    }
    /**
     *
     */
    func describe(){
        StyleParser.describe(self)
    }
}
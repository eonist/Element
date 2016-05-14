import Foundation

protocol IStyle {
    /*getters / setters*/
    var name:String {get}
    var selectors:Array<ISelector> {get}
    var styleProperties:Array<IStyleProperty> {get set}
    /*core methods*/
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
    func addStyleProperties(styleProperties:Array<IStyleProperty>)
    /*implicit getters / setters*/
    func getStyleProperty(name:String,_ depth:Int)->IStyleProperty?
    func getValueAt(index:Int)->Any
    func getValue(name:String,_ depth:Int)->Any?
    func getStyleProperties(name:String)->Array<IStyleProperty>
    func getStylePropertyAt(index:Int)->IStyleProperty
}
extension IStyle{
    /**
     * Convenience method since apple doesnt support default values in protocols
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
}
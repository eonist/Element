import Foundation

protocol IStyleProperty {
    var value: Any {get set}
    var name:String {get set}
    var depth:Int {get}
}
extension IStyleProperty{
    /**
     * Converts xml to a Selector
     */
    static func styleProperty(xml:XML)->IStyleProperty{
        //Swift.print("xml.string: " + "\(xml.string)")
        let name:String = xml.firstNode("name")!.value
        //Swift.print("element: " + "\(element)")
        let valueXML:XML = xml.firstNode("value")!
        let valueType:String = valueXML["type"]!
        
        let strVal:String = xml.firstNode("value")!.value
        //Swift.print("val: " + "\(val)")
        let value:Any? = strVal.count != 0 ? ReflectionUtils.toType(strVal, valueType) : nil
        
        let depth:Int = xml.firstNode("depth")!.value.int
       
        return StyleProperty(name,value,depth)
    }
}
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
        Swift.print("valueXML.XMLString: " + "\(valueXML.XMLString)")
        
        
        
        let value:Any? = nil//ReflectionUtils.toType(valueXML)
        
        let depth:Int = xml.firstNode("depth")!.value.int
       
        fatalError("this is out of order atm")
        
        //return StyleProperty(name,value,depth)
    }
}
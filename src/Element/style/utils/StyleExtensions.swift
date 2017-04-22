import Foundation
@testable import Utils

extension Style:UnWrappable{
    static var clear:IStyle = Style("clear",[],[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])//this won't work since it doesnt have any selectors
    
    init(_ id:String,_ styleProperty:IStyleProperty){/*Convenience*/
        self.init(id,[],[styleProperty])
    }
}
extension Style{
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

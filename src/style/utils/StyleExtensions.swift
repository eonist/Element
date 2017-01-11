import Foundation

extension Style:UnWrappable{
    /**
     * Converts xml to a Style instance
     * IMPORTANT: this must be located here because it belongs in the Element lib but uses the swift-utils lib
     */
    static func unWrap<T>(xml:XML) -> T? {
        let name:String = unWrap(xml, "name")!
        //Swift.print("UnWrap.name: " + "\(name)")
        let styleProperties:[StyleProperty?] = unWrap(xml, "styleProperties")
        //Swift.print("styleProperties.count: " + "\(styleProperties.count)")
        let selectors:[Selector?] = unWrap(xml, "selectors")
        //Swift.print("selectors.count: " + "\(selectors.count)")
        return Style(name,selectors.flatMap{$0},styleProperties.flatMap{$0}) as? T
    }
}
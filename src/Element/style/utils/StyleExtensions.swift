import Foundation
@testable import Utils

extension Style:UnWrappable{
    static var clear:Stylable = Style("clear",[],[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])//this won't work since it doesnt have any selectors
    init(_ id:String,_ styleProperty:StylePropertyKind){/*Convenience*/
        self.init(id,[],[styleProperty])
    }
}
extension Style{
    /**
     * Converts xml to a Style instance
     * IMPORTANT: ⚠️️ this must be located here because it belongs in the Element lib but uses the swift-utils lib
     */
    static func unWrap<T>(_ xml:XML) -> T? {
        let name:String = unWrap(xml, "name")!
        let styleProperties:[StyleProperty?] = unWrap(xml, "styleProperties")
        let selectors:[Selector?] = unWrap(xml, "selectors")
        return Style(name,selectors.flatMap{$0},styleProperties.flatMap{$0}) as? T
    }
    /**
     * New
     * IMPORTANT: ⚠️️ You aperantly have to use Style, protocols are not mutable apperantly
     */
    mutating func setStyleProperty(_ styleProp:StylePropertyKind){
        StyleModifier.overrideStyleProperty(&self, styleProp)
    }
}

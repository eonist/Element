import Foundation

/**
 * NOTE: variables that are Of type Any are a bit tricky because swift is a type safe language
 * NOTE: The commonly used types could be reused and then only have the custom "one of" classes in this method
 * IMPORTANT: this must be located here because it belongs in the Element lib but uses the swift-utils lib
 */
extension StyleProperty:UnWrappable{
    static func unWrap<T>(xml:XML) -> T? {
        let name:String = unWrap(xml, "name")!
        let value:Any = UnWrapUtils.any(xml,"value")
        let depth:Int = unWrap(xml, "depth")!
        return StyleProperty(name,value,depth) as? T
    }
}
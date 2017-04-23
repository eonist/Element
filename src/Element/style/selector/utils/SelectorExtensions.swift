import Foundation
@testable import Utils

extension Selector:UnWrappable{
    /**
     * Converts xml to a Selector instance
     */
    static func unWrap<T>(_ xml:XML) -> T? {
        let element:String = unWrap(xml, "element") ?? ""
        let id:String = unWrap(xml, "id") ?? ""
        let classIds:[String?] = unWrap(xml, "classIds")
        let states:[String?] = unWrap(xml, "states")
        return Selector(element,classIds.flatMap{$0},id,states.flatMap{$0}) as? T
    }
}

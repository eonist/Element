import Foundation

extension Selector:UnWrappable{
    /**
     * Converts xml to a Selector instance
     */
    static func unWrap<T>(xml:XML) -> T? {
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        let element:String = unWrap(xml, "element") ?? ""
        //Swift.print("element: " + "\(element)")
        let id:String = unWrap(xml, "id") ?? ""
        //Swift.print("id: " + "\(id)")
        let classIds:[String?] = unWrap(xml, "classIds")
        let states:[String?] = unWrap(xml, "states")
        //Swift.print("states.count: " + "\(states.count)")
        return Selector(element,classIds.flatMap{$0},id,states.flatMap{$0}) as? T
    }
}
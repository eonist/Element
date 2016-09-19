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
        let value:Any = xml.firstNode("id")!.value
        //Swift.print("id: " + "\(id)")
        let classIds:[String] = xml.firstNode("classIds")!.children?.flatMap{
            ($0 as! XML).value
            } ?? []//<--or empty array
        //Swift.print("classIds.count: " + "\(classIds.count)")
        let states:[String] = xml.firstNode("states")!.children?.flatMap{
            ($0 as! XML).value
            } ?? []//<--or empty array
        //Swift.print("states.count: " + "\(states.count)")
        return Selector(element,classIds,id,states)
    }
}
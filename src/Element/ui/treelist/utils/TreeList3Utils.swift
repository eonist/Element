import Foundation
@testable import Utils



class TreeList3Utils {
    typealias ItemData = (title:String/*,hasChildren:Bool*/,isOpen:Bool,/*isVisible:Bool,*/isSelected:Bool)
    /**
     * Creates a data instance to make it easier to work with the attributes in the xml
     */
    static func itemData(_ xml:XML)->ItemData {
        var attributes:Dictionary<String,String> = XMLParser.attribs(xml)
        let hasChildren:Bool = (attributes["hasChildren"] != nil && attributes["hasChildren"]! == "true") || (xml.children != nil && xml.children!.count > 0)//swift 3 update, simplify this line please
        let title:String = attributes["title"]!
        let isOpen:Bool = attributes["isOpen"] != nil ? attributes["isOpen"] == "true" : false//<- you can shorten this by doing ??
        let isSelected:Bool = attributes["isSelected"] != nil ? attributes["isSelected"] == "true" : false//<- you can shorten this by doing ??
        let isVisible:Bool = attributes["isVisible"] != nil ?  attributes["isVisible"] == "true" : true//<- you can shorten this by doing ??
        return ItemData(title, hasChildren, isOpen, isVisible, isSelected)
    }
    /**
     * New
     */
    static func itemData(_ treeList:TreeList3,_ idx3d:[Int]) -> ItemData? {
        if let tree:Tree = treeList.treeDP.tree[idx3d]{
            if let props = tree.props{
                let title:String = props["title"] ?? ""
                let isOpen:Bool = props["isOpen"] == "true" : false//<- you can shorten this by doing ??
                let isSelected:Bool = attributes["isSelected"] != nil ? props["isSelected"] == "true" : false//<- you can shorten this by doing ??
            }
        }
        
        return nil
    }
}

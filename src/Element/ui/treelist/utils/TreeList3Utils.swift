import Foundation
@testable import Utils
typealias ItemData3 = (title:String/*,hasChildren:Bool*/,isOpen:Bool,/*isVisible:Bool,*/isSelected:Bool)
class TreeList3Utils {
    /**
     * Creates a data instance to make it easier to work with the attributes in the xml
     */
    private static func itemData(_ tree:Tree)->ItemData3? {
        if let props = tree.props{
            let title:String = props["title"] ?? ""
            let isOpen:Bool = props["isOpen"] != nil ? props["isOpen"] == "true" : false//<- you can shorten this by doing ??
            let isSelected:Bool = props["isSelected"] != nil ? props["isSelected"] == "true" : false//<- you can shorten this by doing ??
            return ItemData3(title, isOpen, isSelected)
        };return nil
    }
    /**
     * New
     */
    static func itemData(_ treeList:TreeListable3,_ idx3d:[Int]) -> ItemData3? {
        if let tree:Tree = treeList.treeDP.tree[idx3d]{
            return itemData(tree)
        }
        return nil
    }
    
}

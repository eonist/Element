import Foundation

class TreeList3Asserter {
    /**
     * New
     * idx3d
     */
    static func hasAttribute(_ treeList:TreeListable3, _ idx3d:[Int], _ key:String) -> Bool{
        return TreeDPParser.getProp(treeList.treeDP, idx3d, key) != nil
    }
    /**
     * idx2d
     */
    static func isOpen(_ treeList:TreeListable3, _ idx2d:Int) -> Bool{
        return TreeDPParser.getProp(treeList.treeDP, idx2d, "isOpen") == "true"
    }
    /**
     * idx3d
     */
    static func isOpen(_ treeList:TreeListable3, _ idx3d:[Int]) -> Bool{
        return TreeDPParser.getProp(treeList.treeDP, idx3d, "isOpen") == "true"
    }
    /**
     * New
     */
    static func hasChildren(_ treeList:TreeListable3,_ idx3d:[Int]) -> Bool{
        return TreeAsserter.hasChildren(treeList.treeDP.tree, idx3d)
    }
}

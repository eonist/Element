import Foundation

class TreeList3Asserter {
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
}

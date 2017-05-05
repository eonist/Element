import Foundation
@testable import Utils
@testable import Element

class TreeList3Parser {
    /**
     * Returns idx2d for idx3d
     */
    static func idx2d(_ treeList:TreeListable3,_ idx3d:[Int])->Int?{
        return treeList.treeDP[idx3d]
    }
    /**
     * Returns idx3d for idx2d
     */
    static func idx3d(_ treeList:TreeListable3,_ idx2d:Int)->[Int]?{
        return treeList.treeDP[idx2d]
    }
    /**
     * Returns the seleted idx3d
     * NOTE: to get idx2d, you can use treeList.selectedIdx
     */
    static func selected(_ treeList:TreeListable3) -> [Int]?{
        guard let idx2d = treeList.selectedIdx else {
            return nil
        }
        return treeList.treeDP[idx2d]
    }
    /**
     * Returns the selected Tree
     */
    static func selected(_ treeList:TreeListable3) -> Tree?{
        guard let idx3d:[Int] = TreeList3Parser.selected(treeList) else{
            return nil
        }
        return treeList.treeDP.tree.child(idx3d)
    }
    //continue here: add item(at:)
        //make extensions as well
}

import Foundation
@testable import Utils

class HashList2Modifier {
    /**
     * Inserts descendants into the 2d list
     */
    static func addDescendants(_ list:inout [[Int]], _ idx2d:Int, _ idx3d:[Int], _ tree:Tree) -> Int{
        //Swift.print("idx3d: " + "\(idx3d)")
        //you want all open descendants at 3dIdx
        var indecies:[[Int]] = TreeUtils.pathIndecies(tree,idx3d,TreeUtils.isOpen)/*flattens 3d to 2d*/
        indecies = indecies.map{idx3d + $0}//prepend the parent pathIdx to get complete pathIndecies
        //Swift.print("idx: " + "\(idx)")
        //Swift.print("indecies: " + "\(indecies)")
        let indexAfter:Int = idx2d+1/*we need to inser after idx*/
        list.insert(contentsOf: indecies, at: indexAfter)
        return indecies.count
    }
    /**
     * Remove descendants into the 2d list
     */
    static func removeDescendants(_ list:inout [[Int]],_ idx2d:Int,_ idx3d:[Int], _ tree:Tree) -> Int{
        //Swift.print("🍐 removeDescendants")
        //Swift.print("at: " + "\(at)")
        //Swift.print("list: " + "\(list)")
        //Swift.print("idx3d: " + "\(idx3d)")
        let child:Tree = tree[idx3d]!
        //Swift.print("child.children.count: " + "\(child.children.count)")
        let count:Int = child.count(TreeUtils.isOpen)/*recursive count that traverses the hierarchy*/
        //Swift.print("removeDescendants.count: " + "\(count)")
        let end:Int = idx2d + count
        Swift.print("end: " + "\(end)")
        _ = ArrayModifier.removeRange(&list, idx2d + 1,end + 1)
        return count
    }
}

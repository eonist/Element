import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: To move things up and down hierarchy levels all you do is cut and paste the item, see legacy methods for how to do this
 */
class TreeList3AdvanceModifier {
    /**
     * NOTE: To explode the entire treeList pass an empty array as PARAM: index
     */
    static func explode(_ treeList:TreeListable3,_ idx3d:[Int]) {
        if let range:Range<Int> = Utils.explode(treeList, idx3d){
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.add, range.start,range.end, treeList.dp))
        }
    }
    /**
     * Explodes the children at PARAM: idx3d
     * NOTE: Works great in root for instance aka idx3d: []
     */
    static func explodeAll(_ treeList:TreeListable3,_ idx3d:[Int]){
        if let child:Tree = treeList.treeDP.tree[idx3d] {
            let idx2d:Int = treeList.treeDP[idx3d] ?? 0//if none exist then it root
            var totCount:Int = 0
            child.children.indices.forEach { i in
                let subIdx3d:[Int] = (idx3d + [i])
                if let range:Range<Int> = Utils.explode(treeList, subIdx3d){
                    totCount += range.length
                }
            }
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.add,idx2d,idx2d+totCount,treeList.dp))
        }
    }
    /**
     * Collapses descendants (if you want to close the item at idx3d as well, then use the folow this call by a close call)
     * TODO: Consider adding flag to close it self as well
     * NOTE: This method collapses all nodes from the PARAM: index
     * NOTE: A goal here is to call onEvent only once
     * NOTE: To collapse the entire treeList pass an empty array as PARAM: index
     * NOTE: You can collapse the entire list and follow it with an open call. this repoens root again
     */
    static func collapse(_ treeList:TreeListable3,_ idx3d:[Int]) {
        //Swift.print("collapse")
        if let range:Range<Int> = Utils.collapse(treeList, idx3d){
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.remove,range.start,range.end,treeList.dp))
        }
    }
    /**
     * Collapses the children at PARAM: idx3d
     * NOTE: Works great in root for instance aka idx3d: []
     */
    static func collapseAll(_ treeList:TreeListable3,_ idx3d:[Int]){
        if let child:Tree = treeList.treeDP.tree[idx3d] {
            let idx2d:Int = treeList.treeDP[idx3d] ?? 0//if none exist then it root
            var totCount:Int = 0
            child.children.indices.forEach { i in
                let subIdx3d:[Int] = (idx3d + [i])
                if let range:Range<Int> = Utils.collapse(treeList, subIdx3d){
                    totCount += range.length
                }
            }
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.remove,idx2d,idx2d+totCount,treeList.dp))
        }
    }
    /**
     * TODO: Should explode each node until it reaches its idx3d
     * NOTE: when to use this? When you programatically want to reveal an item deeply nested in the tree-structure
     * TODO: acompany this method with a scrollTo(idx3d) method
     */
    static func reveal(){
        
    }
}
private class Utils{
    /**
     * New
     */
    static func collapse(_ treeList:TreeListable3,_ idx3d:[Int]) -> Range<Int>?{
        if let child:Tree = treeList.treeDP.tree[idx3d], let isOpen = child.props?["isOpen"], isOpen == "true", let idx2d = treeList.treeDP[idx3d]{/*if has isOpen param and it's set to false, item at idx3d was open*/
            let count:Int = HashList2Modifier.removeDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*1.Remove all descendants to 2d list*/
            TreeList3Modifier.recursiveApply(&treeList.treeDP.tree[idx3d]!,TreeList3Modifier.setValue,("isOpen","false"))/*2.Traverse all items and set to close*/
            return idx2d..<(idx2d+count)/*3.Use the count to update DP and UI*/
        }
        return nil
    }
    /**
     * New
     */
    static func explode(_ treeList:TreeListable3,_ idx3d:[Int]) -> Range<Int>?{
        if let isOpen = treeList.treeDP.tree.props?["isOpen"] ,isOpen == "true",let idx2d:Int = treeList.treeDP[idx3d] {/*if has isOpen param and its set to false, already open*/
            _ = HashList2Modifier.removeDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*remove items from HashList (via HashListModifier.removeDescendants)*/
            TreeList3Modifier.recursiveApply(&treeList.treeDP.tree[idx3d]!,TreeList3Modifier.setValue,("isOpen","true"))/*1.traverse all items and set to open*/
            let count:Int = HashList2Modifier.addDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*2.add all descedants to 2d list*/
            return idx2d..<(idx2d+count)/*3.Use the count to update DP and UI*/
        }
        return nil
    }
}

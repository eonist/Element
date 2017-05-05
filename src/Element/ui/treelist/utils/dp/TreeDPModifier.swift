import Foundation
@testable import Utils

class TreeDPModifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp: TreeDP, _ idx2d:Int){
        //Swift.print("TreeDP2Modifier.open")
        let idx3d:[Int] = dp.hashList[idx2d]
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        let count:Int = HashList2Modifier.addDescendants(&dp.hashList, idx2d, idx3d, dp.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
        dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+count, dp))
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp: TreeDP, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        let count:Int = HashList2Modifier.removeDescendants(&dp.hashList, idx2d, idx3d, dp.tree)/*remove items from HashList (via HashListModifier.removeDescendants)*/
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+count, dp))
    }
    /**
     * New
     * TODO: ⚠️️ A more efficient way of doing this would be to insert pathIndecies only for the affected items
     */
    static func insert(_ dp: TreeDP, _ idx3d:[Int], _ tree:Tree){
        //Swift.print("insert \(tree.name) at \(idx3d)")
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            TreeModifier.insert(&dp.tree, idx3d, tree)
            //tree.describe(dp.tree, "title")
            dp.hashList = TreeUtils.pathIndecies(dp.tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
            dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+1, dp))/*updates fastlist UI*/
        }
    }
    /**
     * New
     * TODO: create remove for idx2d as well, maybe!?!?
     * TODO: ⚠️️ A more efficient way of doing this would be to insert pathIndecies only for the affected items
     */
    static func remove(_ dp: TreeDP, _ idx3d:[Int]){
        //Swift.print("TreeDP2Modifier.remove at: \(idx3d)")
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            //Swift.print("idx2d: " + "\(idx2d)")
            TreeModifier.remove(&dp.tree, idx3d)
            /*dp.tree.children.forEach {
             Swift.print("$0.name: " + "\($0.props?["title"])")
             }*/
            dp.hashList = TreeUtils.pathIndecies(dp.tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
            //Swift.print("dp.hashList: " + "\(dp.hashList)")
            dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+1, dp))
        }
    }
    /**
     * New
     * TODO: ⚠️️ A more efficient way of doing this would be to insert pathIndecies only for the affected items
     */
    static func append(_ dp: TreeDP, _ idx3d:[Int], _ child:Tree){
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            TreeModifier.append(&dp.tree, idx3d, child)
            dp.hashList = TreeUtils.pathIndecies(dp.tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
            dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+1, dp))
        }
    }
}

/*static func open(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }
 static func close(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }*/

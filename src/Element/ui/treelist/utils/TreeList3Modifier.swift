import Foundation
@testable import Utils

class TreeList3Modifier {
    /**
     * Sets a selectable in PARAM: treeList at PARAM: index (array index)
     * NOTE: this does not unselect previously selected items.
     */
    static func select(_ treeList:TreeListable3, _ idx3d:[Int],_ isSelected:Bool = true) {
        if let idx2d:Int = TreeList3Parser.idx2d(treeList, idx3d){//get idx2d
            FastList3Modifier.select(treeList, idx2d, isSelected)
        }
    }
    /**
     * NOTE:: this function works as long as multiple selection is not allowed in the treeList
     */
    static func unSelectAll(_ treeList:TreeListable3){
        if let idx3d:[Int] = TreeList3Parser.selected(treeList) {
            select(treeList, idx3d, false)
        }
    }
    /**
     * Open a PARAM: treeList at PARAM: idx3d
     */
    static func open(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDPModifier.open(treeList.treeDP, idx2d)
        }
    }
    /**
     * Close a PARAM: treeList at PARAM: idx3d
     */
    static func close(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDPModifier.close(treeList.treeDP, idx2d)
        }
    }
    /**
     * New
     */
    static func insert(_ treeList:TreeListable3, _ idx3d:[Int],_ tree:Tree){
        TreeDPModifier.insert(treeList.treeDP, idx3d, tree)
    }
    /**
     * New
     */
    static func remove(_ treeList:TreeListable3,_ idx3d:[Int]){
        TreeDPModifier.remove(treeList.treeDP, idx3d)
    }
    /**
     * New
     */
    static func append(_ treeList:TreeListable3,_ idx3d:[Int],_ child:Tree){
        TreeDPModifier.append(treeList.treeDP, idx3d, child)
    }
    typealias KeyValue = (key:String,val:String)
    typealias Apply = (_ tree:inout Tree, _ prop:KeyValue) -> Void
    /**
     * TODO: ⚠️️ I think updateValue is better to use here. Check docs
     */
    static var setValue:Apply = {tree,prop in
        if tree.props != nil && tree.props!.hasKey(prop.key) {/*only sets value if key already exists*/
            tree.props?[prop.key] = prop.val
        }
    }
    /**
     * EXAMPLE: recursiveApply(tree[idx3d],setValue,("isOpen","true"))
     * NOTE: This method traverses down hierarchy
     */
    static func recursiveApply(_ tree:inout Tree, _ apply:@escaping Apply, _ prop:KeyValue){
        apply(&tree,prop)
        for i in tree.children.indices {//it could be possible to use forEach here, test may be needed
            recursiveApply(&tree.children[i],apply,prop)
        }
    }
}

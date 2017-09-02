import Foundation
@testable import Utils

extension TreeListable3 {
    //add convenience methods here
    var selected:Tree? {return TreeList3Parser.selected(self)}
    func open(_ idx3d:[Int]){/*Convenience*/
        TreeList3Modifier.open(self, idx3d)
    }
    func close(_ idx3d:[Int]){/*Convenience*/
        TreeList3Modifier.close(self, idx3d)
    }
    func select(_ idx3d:[Int],_ isSelected:Bool = true) {
        TreeList3Modifier.select(self, idx3d, isSelected)
    }
    func explode(_ idx3d:[Int]) {
        TreeList3AdvanceModifier.explode(self, idx3d)
    }
    func explodeAll(_ idx3d:[Int]) {
        TreeList3AdvanceModifier.explodeAll(self, idx3d)
    }
    func collapse(_ idx3d:[Int]){
        TreeList3AdvanceModifier.collapse(self, idx3d)
    }
    func collapseAll(_ idx3d:[Int]){
        TreeList3AdvanceModifier.collapseAll(self, idx3d)
    }
    func unSelectAll(){
        TreeList3Modifier.unSelectAll(self)
    }
    /**
     * TODO: move the idx3d after the item
     */
    func insert(_ idx3d:[Int],_ item:Tree){
        TreeList3Modifier.insert(self,idx3d,item)
    }
    func remove(_ idx3d:[Int]){
        TreeList3Modifier.remove(self, idx3d)
    }
    func append(_ idx3d:[Int],_ item:Tree){
        TreeList3Modifier.append(self, idx3d, item)
    }
    var selectedIdx3d:[Int]? {return TreeList3Parser.selected(self)}
    var xml:XML {return self.treeDP.tree.xml}
    var tree:Tree {return self.treeDP.tree}
    var hashList:[[Int]] {return self.treeDP.hashList}
    /**
     * Returns prop value for idx3d and key
     */
    subscript(idx3d:[Int],key:String) -> String? {
        return TreeDPParser.getProp(self.treeDP, idx3d, key)
    }
    /**
     * New
     */
    subscript(idx3d:[Int])->Tree?{
        return self.tree.child(idx3d)
    }
    /**
     * New
     */
    func hasChildren(_ idx3d:[Int])-> Bool{
        return TreeList3Asserter.hasChildren(self,idx3d)
    }
}

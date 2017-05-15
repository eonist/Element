import Foundation
@testable import Utils

class TreeModifier {
    typealias ApplyMethod = (_ tree:inout Tree)->Void
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     * TODO: ⚠️️ It could be enough to get the child and then just set the props to that!?!? test later
     */
    static func setProp(_ tree:inout Tree,_ idx3d:[Int], _ prop:(key:String,val:String)) {
        //may work
        let apply:ApplyMethod = {tree in//maybe move into global class scope
            tree.props?[prop.key] = prop.val
        }
        TreeModifier.apply(&tree, idx3d, apply)
    }
    /**
     * EXAMPLE: setAttributeAt([0], ["title":"someTitle"]);
     * TODO: rename to changeAttribute? or editAttribute?
     * TODO: ⚠️️ It could be enough to get the child and then just set the props to that!?!? test later
     */
    static func setProp(_ tree:inout Tree,_ idx3d:[Int],_ props:[String:String]){
        props.forEach { k, v in
            _ = TreeModifier.setProp(&tree, idx3d, (k, v))
        }
    }
    /**
     * New
     */
    static func setName(_ tree:inout Tree,_ idx3d:[Int],_ name:String){
        let apply:ApplyMethod = {tree in
            tree.name = name
        }
        TreeModifier.apply(&tree, idx3d, apply)
    }
    /**
     * New
     */
    static func setContent(_ tree:inout Tree,_ idx3d:[Int],_ content:String){
        let apply:ApplyMethod = {tree in
            tree.content = content
        }
        TreeModifier.apply(&tree, idx3d, apply)
    }
    /**
     * New
     */
    static func setChildren(_ tree:inout Tree,_ idx3d:[Int],_ children:[Tree]){
        let apply:ApplyMethod = {tree in
            tree.children = children
        }
        TreeModifier.apply(&tree, idx3d, apply)
    }
    /**
     * Applies a method at PARAM: idx3d
     * TODO: Clean up with multi if let and guard
     * NOTE: Recursivly traverses the hierarchy until it finds the idx3d and then applies the apply method to the item at idx3d
     */
    static func apply(_ tree:inout Tree, _ idx3d:[Int], _ apply:ApplyMethod){
        if(idx3d.count == 0) {
            apply(&tree)
        }else if(idx3d.count == 1 && tree[idx3d.first!] != nil) {
            apply(&tree[idx3d[0]]!)
        }else if(idx3d.count > 1 && tree.children.count > 0) {
            TreeModifier.apply(&tree[idx3d.first!]!, idx3d.slice2(1,idx3d.count),apply)//keep digging
        }
    }
    /**
     * New
     */
    static func insert(_ tree: inout Tree,_ idx3d:[Int],_ child:Tree){
        if idx3d.count == 1 {
            tree.children.insert(child, at: idx3d[0])
        }else if idx3d.count > 1{
            let parentIdx3d:[Int] = Array(idx3d[0...(idx3d.count-1)])
            tree[parentIdx3d]?.children.insert(child, at: idx3d.last!)//should work
        }else{
            fatalError("Index not supported: \(idx3d)")
        }
    }
    /**
     * New
     */
    static func append(_ tree: inout Tree,_ idx3d:[Int],_ child:Tree){
        tree[idx3d]?.children.append(child)
    }
    /**
     * IMPORTANT: idx3d must have at least one value
     * NOTE: to "removeAll" you can do: tree.children = []
     */
    static func remove(_ tree: inout Tree,_ idx3d:[Int]){
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        if let parent:Tree = tree[parentTreeIdx3d], let last:Int = idx3d.last, parent.count < last {
            tree[parentTreeIdx3d]!.children.remove(at: idx3d.last!)
        }else{
            fatalError("parent.children.count: \(tree[parentTreeIdx3d]?.count) last: \(idx3d.last)")
        }
    }
    
}

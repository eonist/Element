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
     * Changes multiple proops at idx3d in tree
     * EXAMPLE: setAttributeAt([0], ["title":"someTitle"]);
     * TODO: ⚠️️ rename to changeAttribute? or editAttribute?
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
     * TODO: ⚠️️ Clean up with multi if let and guard
     * NOTE: Recursivly traverses the hierarchy until it finds the idx3d and then applies the apply method to the item at idx3d
     * EXAMPLE: let tree = Tree("a");TreeModifier.apply(&tree, [], { $0.name = $0.name?.capitalized}); TreeUtils.describe(tree)//a
     */
    static func apply(_ tree:inout Tree, _ idx3d:[Int], _ apply:ApplyMethod){
        if idx3d.isEmpty{
            apply(&tree)
        }else if idx3d.count == 1 && tree[idx3d.first!] != nil  {
            apply(&tree[idx3d[0]]!)
        }else if idx3d.count > 1 && !tree.children.isEmpty {
            TreeModifier.apply(&tree[idx3d.first!]!, idx3d.slice2(1,idx3d.count),apply)//keep digging
        }
    }
    /**
     * New, can be written more optimized.
     * IMPORTANT: ⚠️️ Does not apply to root tree. Use apply(tree,..) if you want to alter root as well
     * EXAMPLE: var tree = Tree("a",[Tree("a.1"),Tree("a.2",[Tree("a.2.1")])])
     * EXAMPLE: TreeModifier.applyAll(tree:&tree,idx3d:[], apply:{ $0.name = $0.name?.capitalized}/*,includeSelf:true*/)//
     * EXAMPLE: TreeUtils.describe(tree)//a, A.1, A.2, A.2.1
     */
    static func applyAll( tree:inout Tree, idx3d:[Int], apply:ApplyMethod/*, includeSelf:Bool = false*/){
      TreeUtils.pathIndecies(tree,at:idx3d).forEach {
            let index3d = idx3d + $0//we need the full 3d index
//            Swift.print("index3d: " + "\(index3d)")
            TreeModifier.apply(&tree, index3d , apply)
        }
    }
    /**
     * New
     */
    static func insert(_ tree: inout Tree,_ idx3d:[Int],_ child:Tree){
        if idx3d.count == 1 {
            tree.children.insert(child, at: idx3d[0])
        }else if idx3d.count > 1{
            let parentIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
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
     * IMPORTANT: ⚠️️ idx3d must have at least one value
     * NOTE: to "removeAll" you can do: tree.children = []
     */
    static func remove(_ tree: inout Tree,_ idx3d:[Int]){
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        if let parent:Tree = tree[parentTreeIdx3d], let last:Int = idx3d.last,  parent.children[safe:last] != nil {//use <- contains here instead
            Swift.print("parent.children.count: \(tree[parentTreeIdx3d]!.count.string) last: \(idx3d.last!.string)")
            tree[parentTreeIdx3d]!.children.remove(at: idx3d.last!)
        }else{
            fatalError("parent.children.count: \(tree[parentTreeIdx3d]!.count.string) last: \(idx3d.last!.string)")
        }
    }
    
}

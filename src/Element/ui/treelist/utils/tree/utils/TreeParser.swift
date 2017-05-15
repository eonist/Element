import Foundation
@testable import Utils

class TreeParser {
    /**
     * Returns a child at PARAM: idx3d
     * NOTE: this function is recursive
     * NOTE: to find the children of the root use an empty array as the index value
     */
    static func child(_ tree:Tree?,_ idx3d:[Int])->Tree?{
        if(idx3d.count == 0 && tree != nil) {
            return tree
        }else if(idx3d.count == 1 && tree != nil && tree![idx3d.first!] != nil) {//XMLParser.childAt(xml!.children!, index[0])
            return tree![idx3d[0]]
        }// :TODO: if index.length is 1 you can just ref index
        else if(idx3d.count > 1 && tree!.children.count > 0) {
            return TreeParser.child(tree![idx3d.first!], idx3d.slice2(1,idx3d.count))
        }
        return nil
    }
    /**
     * Returns an 2d-list containing every idx3d indecies of each item in the 3d-structure
     * NOTE: root isn't considered item 0. Only descendents from root are considered items
     * PARAM: at: the index of am item as if the tree structure was flattened
     */
    static func descendants(_ tree:Tree, _ at:Int)->Tree?{
        var i:Int = 0
        return Utils.descendants(tree, at, &i)
    }
    
    /**
     * idx3d above PARAM: idx3d
     */
    static func above(_ tree: Tree,_ idx3d:[Int]) -> [Int]? {
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        return idx3d.last! > 0 ? parentTreeIdx3d + [idx3d.last!-1] : nil
        /*_ = tree[parentTreeIdx3d]?.children.displace(idx3d.last!,idxAbove)*/
    }
    /**
     * idx3d bellow PARAM: idx3d
     */
    static func bellow(_ tree:Tree,_ idx3d:[Int]) -> [Int]?{
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        if let childrenCount:Int = tree[parentTreeIdx3d]?.children.count{
            let idxBellow:Int = idx3d.last! < childrenCount ? idx3d.last!+1:childrenCount
            /*_ = tree[parentTreeIdx3d]?.children.displace(idx3d.last!,idxBellow)*/
            return parentTreeIdx3d + [idxBellow]
        }else{
            return nil
        }
    }
    /**
     * idx3d top of at parent of PARAM: idx3d
     */
    static func top(_ tree:  Tree,_ idx3d:[Int]) -> [Int]?{
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        /*if idx3d.last! > 0 {_ = tree[parentTreeIdx3d]?.children.displace(idx3d.last!,0)}*/
        return idx3d.last! > 0 ? parentTreeIdx3d + [0] : nil
    }
    /**
     * idx3d bottom of at parent of PARAM: idx3d
     */
    static func bottom(_ tree:  Tree,_ idx3d:[Int]) -> [Int]?{
        if idx3d.isEmpty {fatalError("Index not supported: \(idx3d)")}
        let parentTreeIdx3d:[Int] = TreeUtils.parentIndex(idx3d)
        if let childrenCount:Int = tree[parentTreeIdx3d]?.children.count, idx3d.last! < childrenCount {
            /*_ = tree[parentTreeIdx3d]?.children.displace(idx3d.last!,childrenCount)*/
            return parentTreeIdx3d + [childrenCount]
        }else{
            return nil
        }
    }
}
private class Utils{
    /**
     * NOTE: this method resides in a Utility method because PARAM: i can't have default value
     */
    static func descendants(_ child:Tree, _ at:Int, _ i:inout Int)->Tree?{
        for item in child.children{
            if(at == i){return item}/*found item at index*/
            else{
                i += 1
                if(item.children.count > 0){
                    let match:Tree? = Utils.descendants(item,at,&i)
                    if(match != nil){return match}
                }
            }
        }
        return nil
    }
}

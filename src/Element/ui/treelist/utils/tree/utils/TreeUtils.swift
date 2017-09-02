import Foundation
@testable import Utils

class TreeUtils{
    /*struct PathIdx{
     var idx:[Int]
     init(_ idx:[Int]){
     self.idx = idx
     }
     }*/
    typealias AssertMethod = (_ tree:Tree)->Bool
    static var defaultAssert:AssertMethod = {_ in return true}//returns true as default
    /**
     * Recusivly flattens the the treeStructure into a column structure array of tree items
     * TODO: ⚠️️ Use reduce!
     * TODO: ⚠️️ move to TreeParser?
     */
    static func flattened(_ tree:Tree) -> [Tree] {
        var results:[Tree] = []
        tree.children.forEach { child in
            if !child.children.isEmpty {/*Array*/
                results += TreeUtils.flattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
    /**
     * New
     * Returns an Array of idx3d that asserts to the PARAM: assert
     * EXAMPLE: var tree = Tree("a",[Tree("a.1"),Tree("a.2",[Tree("a.2.1")])])
     * EXAMPLE: let descendant3dIndicies = TreeUtils.pathIndecies(tree,[])
     * EXAMPLE: descendant3dIndicies.forEach{Swift.print($0)}
     * OUTPUT: [0]
     * OUTPUT: [1]
     * OUTPUT: [1, 0]
     * IMPORTANT: ⚠️️ Tree root will never be included in the result. Append it if you need to use root as well
     * IMPORTANT: ⚠️️ The 3dIdx is from the perspective of the child. Append idx3d to the pathIndecies to get the full idx3d
     */
    static func pathIndecies(_ tree:Tree, at idx3d:[Int] = [], with assert:AssertMethod = defaultAssert) -> [[Int]] {
        let child:Tree = TreeParser.child(tree, idx3d)!
        return Utils.pathIndecies(child, [], assert)//TODO:  ⚠️️ we could probably pass the idx3d here and drop the child?!?
    }
    /**
     * Used to debug Trees
     * TODO: ⚠️️ make a describe method that prints the entire tree with tabbing, and include name in the tree, and content
     */
    static func describe(_ tree:Tree,_ key:String, _ level:Int = 0){
        if let props = tree.props, let value:String = props[key]{
            Swift.print(("\t" * level) +  value)
        }
        tree.children.forEach{describe($0, key, level + 1)}
    }
    /**
     * New
     */
    static func describe(_ tree:Tree,_ level:Int = 0){
        if let name = tree.name{
            Swift.print(("\t" * level) +  name)
        }
        tree.children.forEach{describe($0, level + 1)}
    }
    /**
     * Assert method for Utils.pathIndecies, Other methods also use this method
     */
    static var isOpen:TreeUtils.AssertMethod = { tree in
        guard let props = tree.props, props["isOpen"] == "true" else {
            return false
        }
        return true
    }
    /**
     * EXAMPLE: TreeUtils.parentIndex([2,1,3,4])//[2, 1, 3]
     */
    static func parentIndex(_ idx3d:[Int]) -> [Int]{
        return idx3d.count > 1 ? Array(idx3d[0..<(idx3d.count-1)]) : []
    }
}
private class Utils{
    /**
     * Flattens a Tree-Structure to a path Indecies (3d -> 2d)
     * Eureka: Hash Array: You use a Sorted hashArray to solve the 3d->2d sync problem (Research required)
     */
    static func pathIndecies(_ tree:Tree,_ depth:[Int] = [], _ assert:TreeUtils.AssertMethod = TreeUtils.defaultAssert) -> [[Int]] {
        var depth:[Int] = depth + [0]
        var results:[[Int]] = []
        tree.children.forEach{
            results.append(depth)
            if $0.children.count > 0 && assert($0) {/*Array*/
                results += Utils.pathIndecies($0,depth, assert)//dive deeper
            }
            depth.end = depth.end! + 1//increment cur level
        }
        return results
    }
}

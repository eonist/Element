import Foundation

class TreeAsserter {
    /**
     * Asserts if a tree at PARAM: idx3d has children
     */
    static func hasChildren(_ tree:Tree,_ idx3d:[Int])->Bool{
        if let child:Tree = tree[idx3d]{
            return !child.children.isEmpty
        }
        fatalError("no child at: \(idx3d)")
    }
}

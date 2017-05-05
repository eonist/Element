import Foundation
/**
 * NOTE: Check regexident forest code. and lorentey [Element] ? etc?
 * TODO: maybe rearrange arguments to: name,content,props,children?
 */
//typealias Element = T
struct Tree{
    var children:[Tree]//should be optional, then we would have to init it too often maybe, maybe lazy actually?
    var props:[String:String]?
    var name:String?
    var content:String?/*Could be Generic as well*/
    init(_ name:String? = nil,_ children:[Tree] = [],_ content:String? = nil,  _ props:[String:String]? = nil ) {
        self.children = children
        self.props = props
        self.name = name
        self.content = content
    }
}
/*
 Terminologies used in Trees:
 
 Root – The top node in a tree.
 Child – A node directly connected to another node when moving away from the Root.
 Parent – The converse notion of a child.
 Siblings – Nodes with the same parent.
 Descendant – A node reachable by repeated proceeding from parent to child.
 Ancestor – A node reachable by repeated proceeding from child to parent.
 Leaf – A node with no children.
 Internal node – A node with at least one child
 External node – A node with no children.
 Degree – Number of sub trees of a node.
 Edge – Connection between one node to another.
 Path – A sequence of nodes and edges connecting a node with a descendant.
 Level – The level of a node is defined by 1 + (the number of connections between the node and the root).
 Height of node – The height of a node is the number of edges on the longest path between that node and a leaf.
 Height of tree – The height of a tree is the height of its root node.
 Depth – The depth of a node is the number of edges from the node to the tree's root node.
 Forest – A forest is a set of n ≥ 0 disjoint trees.
 */

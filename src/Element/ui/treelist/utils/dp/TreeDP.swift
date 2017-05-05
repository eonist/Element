import Foundation
@testable import Element
@testable import Utils
/**
 * TODO: Use DataProvidable don't extend DataProvider
 * NOTE: This would allow fast translation between 2d and 3d data structure https://github.com/CosmicMind/Algorithm/blob/master/Sources/SortedDictionary.swift
 * NOTE: for now we have a fast way to translate 2d -> 3d and slow 3d -> 2d. But the later doesn't need to be fast as it is only used when editing 3d structure. 2d -> 3d however needs to be super fast since its accessed very frequently when doing animation
 * TreeDP surogates item(at:Int) in DataProvider. You dont need to touch DataProvider.items
 */
class TreeDP:DataProvider {
    var tree:Tree
    var hashList:[[Int]]/*Stores the idx3d indecies*/
    init(_ tree:Tree){
        self.tree = tree
        self.hashList = TreeUtils.pathIndecies(tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        super.init([])
    }
    /**
     * PARAM: at: 2d idx
     * RETURNS: DataProvider item (aka Dictionary)
     */
    override func item(_ at:Int) -> [String:String]?{
        if let treeIdx:[Int] = hashList[safe:at], let child:Tree = tree[treeIdx]{/*find the 3d-idx*/
            return child.props
        }
        return nil
    }
    override var count:Int{
        return hashList.count//return tree.count
    }
    convenience init(_ fileURLStr:String){
        let xml = FileParser.xml(fileURLStr)
        self.init(xml)
    }
    convenience init(_ xml:XML) {
        let tree:Tree = TreeConverter.tree(xml)
        self.init(tree)
    }
}
extension TreeDP {
    /**
     * Returns idx3d for idx2d
     */
    subscript(_ idx2d:Int) -> [Int] {
        return hashList[idx2d]
    }
    /**
     * Returns idx2d for idx3d
     */
    subscript(_ idx3d:[Int]) -> Int? {
        return hashList.index(where: {$0 == idx3d})
    }
}

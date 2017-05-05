import Foundation
@testable import Utils

class TreeDPParser {
    /**
     * Returns prop-value for idx2d and key
     * EXAMPLE: TreeDP2Parser.getProp(treeDP, idx, "isOpen")
     */
    static func getProp(_ dp: TreeDP, _ idx2d:Int, _ key:String)->String?{
        return getProps(dp, idx2d)?[key]
    }
    /**
     * Returns prop-value for idx3d and key
     */
    static func getProp(_ dp: TreeDP, _ idx3:[Int], _ key:String)->String?{
        return getProps(dp, idx3)?[key]
    }
    /**
     * Returns properties
     */
    static func getProps(_ dp: TreeDP, _ idx2d:Int)->[String:String]?{
        if let idx3d:[Int] = dp.hashList[safe:idx2d]{
            return getProps(dp,idx3d)
        }
        fatalError("no item at: \(idx2d)")
    }
    static func getProps(_ dp: TreeDP, _ idx3d:[Int])->[String:String]?{
        return dp.tree.getProps(idx3d)
    }
    /**
     * TODO: ⚠️️ You can probably chain indices as well
     * TODO: Use .filte instead
     */
    static func values(_ dp: TreeDP, _ idx:[Int], _ key:String)->[String]{
        var indecies:[[Int]] = TreeUtils.pathIndecies(dp.tree,idx,TreeUtils.isOpen)/*flattens 3d to 2d*/
        //Swift.print("indecies: " + "\(indecies)")
        indecies = indecies.map{idx + $0}//prepend the parent pathIdx to get complete pathIndecies
        return indecies.lazy.map{ idx -> String? in
            if let tree = dp.tree[idx],let props:[String:String] = tree.props,let value = props[key]{
                return value
            };return nil
            }.flatMap{$0}/*removes nil*/
    }
}

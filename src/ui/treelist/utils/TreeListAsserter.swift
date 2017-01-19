import Foundation

class TreeListAsserter {
    /**
     *
     */
    class func hasSelected(_ treeList:ITreeList)->Bool {
        let selectedIndex:Array = TreeListParser.selectedIndex(treeList)
        return selectedIndex.count > 0
    }
}

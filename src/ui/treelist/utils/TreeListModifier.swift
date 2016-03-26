import Foundation

class TreeListModifier {
    /**
     * Scrolls the treeList to a scalar position (value 0-1)
     */
    class func scrollTo(treeList:ITreeList,_ progress:CGFloat){
        treeList.itemContainer.y = SliderParser.y(progress, treeList.getHeight(),  TreeListParser.itemsHeight(treeList))
    }
    /**
     * @Note: to explode the entire treeList pass an empty array as @param index
     */
    class func explodeAt(var treeList:ITreeList,_ index:Array<Int>) {
        treeList = TreeListParser.itemAt(treeList, index) as! ITreeList
        if(treeList is ITreeListItem){(treeList as! ITreeListItem).open()}
        var decendants:Array<ITreeList> = TreeListParser.decendantsOfType(treeList,ITreeListItem)
        for each (var treeListItem : ITreeListItem in decendants){
            if(!ICheckable(treeListItem).checked) treeListItem.open()
        }
    }
}

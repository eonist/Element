import Cocoa

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
        let decendants:Array<ITreeListItem> = TreeListParser.decendantsOfType(treeList,ITreeListItem.self)
        for treeListItem:ITreeListItem in decendants{
            if(!(treeListItem as! ICheckable).getChecked()) {treeListItem.open()}
        }
    }
    /**
     * @Note: to collapse the entire treeList pass an empty array as @param index
     * @Note this method collapses all nodes from the @param index
     */
    class func collapseAt(var treeList:ITreeList,_ index:Array<Int>) {
        treeList = TreeListParser.itemAt(treeList, index) as! ITreeList
        let decendants:Array<ITreeListItem> = TreeListParser.decendantsOfType(treeList,ITreeListItem.self)
        for treeListItem : ITreeListItem in decendants {
            if((treeListItem as! ICheckable).getChecked()) {treeListItem.close()}
        }
    }
    /**
     * @Note this method is recursive
     */
    class func addAt(treeList:ITreeList,_ index:Array<Int>,_ item:NSView) {
        if(index.count == 1) {treeList.addItemAt(item,index[0])}
        else if(index.count > 1 && treeList.itemContainer.subviews.count > 0 && treeList.itemContainer.getSubViewAt(index[0]) is ITreeList) {
            addAt(treeList.itemContainer.getSubViewAt(index[0]) as! ITreeList, index.slice2(1,index.count),item)
        }
    }
    /**
     * Sets a selectable in @param treeList at @param index (array index)
     * // :TODO: rename to selectAt
     */
    class func setSelectedAt(treeList:ITreeList, _ index:Array<Int>,_ isSelected:Bool = true) {
        if(index.count == 1 && treeList.itemContainer.subviews.count > 0 && treeList.itemContainer.getSubViewAt(index[0]) is ISelectable) {
            (treeList.itemContainer.getSubViewAt(index[0]) as! ISelectable).setSelected(isSelected)
        }
        else if(index.count > 1 && treeList.itemContainer.subviews.count > 0 && treeList.itemContainer.getSubViewAt(index[0]) is ITreeList) {
            setSelectedAt(treeList.itemContainer.getSubViewAt(index[0]) as! ITreeList, index.slice2(1,index.count),isSelected)
        }
    }
}

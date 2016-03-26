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
        if(index.length == 1) treeList.addItemAt(item,index[0]);
        else if(index.count > 1 && treeList.itemContainer.numChildren > 0 && treeList.itemContainer.getChildAt(index[0]) as ITreeList) {
            addAt(treeList.itemContainer.getChildAt(index[0]) as ITreeList, index.slice(1,index.length),item);
        }
    }
}

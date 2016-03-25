import Foundation

class TreeListParser{
    /**
     * Returns the total height of the items
     * @Note another name for this could be getTotalItemsHeight?
     */
    class func itemsHeight(treeList:ITreeList)->CGFloat{
        var height:CGFloat = 0
        for (var i : Int = 0; i < treeList.itemContainer.subviews.count; i++) {
            height += treeList.itemContainer.getSubviewAt(i) is TreeListItem ? (treeList.itemContainer.getSubviewAt(i) as! TreeListItem).getHeight() : (treeList.itemContainer.getSubviewAt(i) as! Element).getHeight()
        }
        return height
    }
    /**
     * Returns an array of descendants in @param treeList
     */
    class func descendants(treeList:ITreeList)->Array<ITreeList>{
    var items:Array<ITreeList> = [];
    var numChildren:Int = treeList.itemContainer.numChildren;
    for (var i : Int = 0; i < numChildren; i++) {
        var displayObject:DisplayObject = treeList.itemContainer.getChildAt(i);
        items.push(displayObject);
        if(displayObject is ITreeList) items = items.concat(descendants(displayObject as ITreeList));
    }
    return items;
    }
}

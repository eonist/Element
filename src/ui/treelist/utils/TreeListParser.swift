import Cocoa

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
        var items:Array<ITreeList> = []
        let numChildren:Int = treeList.itemContainer.subviews.count
        for (var i : Int = 0; i < numChildren; i++) {
            let view:NSView = treeList.itemContainer.getSubviewAt(i)
            items.append(view as! ITreeList)
            if(view is ITreeList) {items += (descendants(view as! ITreeList))}
        }
        return items
    }
    /**
     *
     */
    class func decendantsOfType(treeList:ITreeList,_ type:AnyClass? = nil)->Array<ITreeList> {
        var items:Array<ITreeList> = []
        for (var i : Int = 0; i < treeList.itemContainer.subviews.count; i++) {
            var view:NSView = treeList.itemContainer.getSubViewAt(i) as! NSView
            if(type == nil || (type != nil && view is type)) {
                items.append(view)
                items += (decendantsOfType(view as! ITreeList,type))
            }
        }
        return items;
    }
}

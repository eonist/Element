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
    class func decendantsOfType<T>(treeList:ITreeList,_ type:T.Type? = nil)->Array<ITreeList> {
        var items:Array<ITreeList> = []
        for (var i : Int = 0; i < treeList.itemContainer.subviews.count; i++) {
            let view:NSView = treeList.itemContainer.getSubviewAt(i)
            if(type == nil || (type != nil && view as? T != nil)) {//<--Inspired from the ClassParser.ofType() method
                items.append(view as! ITreeList)
                items += (decendantsOfType(view as! ITreeList,type))
            }
        }
        return items
    }
    /**
     * Returns the index of @param item from @param treeList
     * // :TODO: this code could possibly be optimized Check similar function: XMLParser.index(xml,attribute) this has simpler syntax
     */
    class func index(treeList:ITreeList,_ item:NSView)->Array<Int> {
        var index:Array<Int> = []
        for (var i : Int = 0; i < treeList.itemContainer.subviews.count; i++) {
            let view:NSView = treeList.itemContainer.getSubviewAt(i)
            if(view === item) {index = [i]}
            else if (view is ITreeList && (view as! ITreeList).itemContainer.subviews.count > 0){
                let tempIndex:Array<Int> = (TreeListParser.index(view as! ITreeList, item))
                if(tempIndex.count > 0) {index = [i] + tempIndex}
            }
        }
        return index;
    }
}

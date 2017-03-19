import Cocoa
@testable import Utils

class TreeListParser{
    /**
     * Returns the total height of the items
     * @Note another name for this could be getTotalItemsHeight?
     */
    static func itemsHeight(_ treeList:ITreeList)->CGFloat{
        var height:CGFloat = 0
        for i in 0..<treeList.itemContainer!.subviews.count{
            height += treeList.itemContainer!.getSubviewAt(i) is TreeListItem ? (treeList.itemContainer!.getSubviewAt(i) as! TreeListItem).getHeight() : (treeList.itemContainer!.getSubviewAt(i) as! Element).getHeight()
        }
        return height
    }
    /**
     * Returns an array of descendants in PARAM: treeList
     */
    static func descendants(_ treeList:ITreeList)->[AnyObject]{
        var items:[AnyObject] = []
        for i in 0..<treeList.itemContainer!.subviews.count{
            let view:NSView = treeList.itemContainer!.getSubviewAt(i)
            //Swift.print("view: " + "\(view)")
            items.append(view)
            if(view is ITreeList) {items += (descendants(view as! ITreeList))}
        }
        return items
    }
    /**
     *
     */
    static func decendantsOfType<T>(_ treeList:ITreeList,_ type:T.Type? = nil)->[T] {
        //Swift.print("decendantsOfType()")
        var items:[T] = []
        for i in 0..<treeList.itemContainer!.subviews.count{
            let view:NSView = treeList.itemContainer!.getSubviewAt(i)
            if(type == nil || (type != nil && view as? T != nil)) {//<--Inspired from the ClassParser.ofType() method
                items.append(view as! T)
                items += (decendantsOfType(view as! ITreeList,type))
            }
        }
        return items
    }
    /**
     * Returns the index of PARAM: item from PARAM: treeList
     * TODO: this code could possibly be optimized Check similar function: XMLParser.index(xml,attribute) this has simpler syntax
     */
    static func index(_ treeList:ITreeList,_ item:NSView)->[Int] {
        var index:[Int] = []
        for i in 0..<treeList.itemContainer!.subviews.count{//swift 3 upgrade
            let view:NSView = treeList.itemContainer!.getSubviewAt(i)
            if(view === item) {index = [i]}
            else if (view is ITreeList && (view as! ITreeList).itemContainer!.subviews.count > 0){
                let tempIndex:[Int] = (TreeListParser.index(view as! ITreeList, item))
                if(tempIndex.count > 0) {index = [i] + tempIndex}
            }
        }
        return index
    }
    /**
     * Returns the index of the selected ISelectable instance in PARAM: treeList
     */
    static func selectedIndex(_ treeList:ITreeList) -> [Int]{
        let selected = self.selected(treeList)
        return index(treeList, selected as! NSView)
    }
    /**
     * Returns the selected ISelectable instance in the PARAM: treeList
     */
    static func selected(_ treeList:ITreeList)->ISelectable?{
        var selectable:ISelectable?
        for i in 0..<treeList.itemContainer!.subviews.count{
            let treeItem:NSView = treeList.itemContainer!.getSubviewAt(i)
            if(treeItem is ISelectable && (treeItem as! ISelectable).getSelected()) {selectable = treeItem as? ISelectable}
            if(treeItem is ITreeListItem && !(treeItem as! ISelectable).getSelected()) {selectable = TreeListParser.selected(treeItem as! ITreeList)}
            if(selectable != nil) {break}//<--What does this break do?, well when the first selectable is found it breaks out of the loop, should probably find a better design for this
        }
        return selectable
    }
    /**
     * Returns an NSView instance at PARAM: index in PARAM: treeList
     */
    static func itemAt(_ treeList:ITreeList,_ index:[Int]) -> NSView{
        if(index.count == 1 && treeList.itemContainer!.getSubViewAt(index[0]) != nil) {
            return treeList.itemContainer!.getSubViewAt(index[0])!
        }else if(index.count > 1 && treeList.itemContainer!.subviews.count > 0 && treeList.itemContainer!.getSubViewAt(index[0]) is ITreeList) {
            return itemAt(treeList.itemContainer!.getSubViewAt(index[0]) as! ITreeList, index.slice2(1, index.count))
        }else {
            return treeList as! NSView/*index.count == 0*/
        }
    }
}

import Cocoa

class TreeListUtils {
    /**
     * Returns SelectTextButton or a TreeListItem from an xml
     * @Note this method is used in the onDataBaseAddAt method in the TreeList class
     */
    class func item(xml:NSXMLElement,parent:IElement,_ size:CGPoint)->NSView {
        var itemData:ItemData = Utils.itemData(xml)
        var item:NSView = Utils.treeItem(itemData, parent, size)
        if(itemData.hasChildren) {treeItems(xml,item as ITreeList,new Point(size.x, size.y)) as NSView}/*Utils.treeItems(xml) and add each DisplayObject in treeItems*/
        return item
    }
}

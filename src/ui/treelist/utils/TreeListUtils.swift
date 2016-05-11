import Cocoa

class TreeListUtils {
    /**
     * Returns SelectTextButton or a TreeListItem from an xml
     * @Note this method is used in the onDataBaseAddAt method in the TreeList class
     */
    class func item(xml:NSXMLElement,_ parent:IElement,_ size:CGPoint)->NSView {
        //Swift.print("item size: " + "\(size)")
        let itemData:ItemData = Utils.itemData(xml)
        let item:NSView = Utils.treeItem(itemData, parent, size)
        if(itemData.hasChildren) {treeItems(xml,item as! ITreeList,CGPoint(size.x, size.y)) as! NSView}/*Utils.treeItems(xml) and add each DisplayObject in treeItems*/
        return item
    }
    /**
     * @Note: This method is recursive
     * @Note only use this method to add children to a new TreeList
     * @param size is the size of each treeItem
     * // :TODO: this should just return not modify?!? and be moved to TreeListParser
     */
    class func treeItems(xml:NSXMLElement, _ treeList:ITreeList, _ size:CGPoint) -> ITreeList {//TODO:use CGSize
        //Swift.print("treeItems size: " + "\(size)")
        for child in xml.children! as! Array<NSXMLElement>{
            let itemData:ItemData = Utils.itemData(child)
            let treeItem:NSView = Utils.treeItem(itemData,treeList.itemContainer as! IElement,size)
            //Swift.print("itemData.hasChildren: " + "\(itemData.hasChildren)")
            if(itemData.hasChildren) {TreeListUtils.treeItems(child,treeItem as! ITreeList,size)}// :TODO: move this line into treeitem?
            treeList.addItem(treeItem)/*Adds the item to the treeList*/
        }
        return treeList
    }
}
private class Utils{
    /**
     * // :TODO: write java doc
     */
    class func treeItem(itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> NSView {
        //Swift.print("treeItem size: " + "\(size)")
        let item:NSView = itemData.hasChildren ? Utils.treeListItem(itemData, parent, size) : Utils.selectTextButton(itemData, parent, size)
        //Swift.print("itemData.isVisible: " + "\(itemData.isVisible)")
        item.hidden = !itemData.isVisible// :TODO: should this be here and do we need isVisible?
        return item
    }
    /**
     * Creates a data instance to make it easier to work with the attributes in the xml
     */
    class func itemData(xml:NSXMLElement)->ItemData {
        var attributes:Dictionary<String,String> = XMLParser.attribs(xml)
        let hasChildren:Bool = attributes["hasChildren"] == "true" || xml.children?.count > 0
        let title:String = attributes["title"]!
        let isOpen:Bool = attributes["isOpen"] != nil ? attributes["isOpen"] == "true" : false//<- you can shorten this by doing ??
        let isSelected:Bool = attributes["isSelected"] != nil ? attributes["isSelected"] == "true" : false//<- you can shorten this by doing ??
        let isVisible:Bool = attributes["isVisible"] != nil ?  attributes["isVisible"] == "true" : true//<- you can shorten this by doing ??
        return ItemData(title, hasChildren, isOpen, isVisible, isSelected)
    }
    class func treeListItem(itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> TreeListItem {
        //Swift.print("treeListItem size: " + "\(size)")
        return TreeListItem(size.x,size.y,itemData.title,itemData.isOpen,itemData.isSelected,parent)
    }
    class func selectTextButton(itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> SelectTextButton {
        //Swift.print("selectTextButton size: " + "\(size)" + " title: " + "\(itemData.title)")
        //Swift.print("parent: " + "\(parent)")
        return SelectTextButton(size.x,size.y,itemData.title,itemData.isSelected,parent)
    }
}
class ItemData{
    private var title:String;
    private var hasChildren:Bool
    private var isOpen:Bool
    private var isVisible:Bool
    private var isSelected:Bool
    init(_ title:String, _ hasChildren:Bool, _ isOpen:Bool, _ isVisible:Bool , _ isSelected:Bool) {
        self.title = title
        self.hasChildren = hasChildren
        self.isOpen = isOpen
        self.isVisible = isVisible
        self.isSelected = isSelected
    }
}
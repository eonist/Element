import Cocoa
@testable import Utils

class TreeListUtils {
    /**
     * Returns SelectTextButton or a TreeListItem from an xml
     * NOTE: this method is used in the onDataBaseAddAt method in the TreeList class
     */
    static func item(_ xml:XMLElement,_ parent:IElement,_ size:CGPoint)->NSView {
        //Swift.print("item size: " + "\(size)")
        let itemData:ItemData = Utils.itemData(xml)
        let item:NSView = Utils.treeItem(itemData, parent, size)
        if(itemData.hasChildren) {_ = treeItems(xml,item as! ITreeList,CGPoint(size.x, size.y)) as! NSView}/*Utils.treeItems(xml) and add each DisplayObject in treeItems*/
        return item
    }
    /**
     * NOTE: This method is recursive
     * NOTE: only use this method to add children to a new TreeList
     * PARAM: size is the size of each treeItem
     * TODO: this should just return not modify?!? and be moved to TreeListParser
     */
    static func treeItems(_ xml:XMLElement, _ treeList:ITreeList, _ size:CGPoint) -> ITreeList {//TODO:use CGSize
        //Swift.print("treeItems size: " + "\(size)")
        for child in xml.children! as! Array<XMLElement>{
            let itemData:ItemData = Utils.itemData(child)
            let treeItem:NSView = Utils.treeItem(itemData,treeList.itemContainer as! IElement,size)
            //Swift.print("itemData.hasChildren: " + "\(itemData.hasChildren)")
            if(itemData.hasChildren) {
                _ = TreeListUtils.treeItems(child,treeItem as! ITreeList,size)
            }// :TODO: move this line into treeitem?
            treeList.addItem(treeItem)/*Adds the item to the treeList*/
        }
        return treeList
    }
}
private class Utils{
    /**
     * // :TODO: write java doc
     */
    static func treeItem(_ itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> NSView {
        //Swift.print("treeItem size: " + "\(size)")
        let item:NSView = itemData.hasChildren ? Utils.treeListItem(itemData, parent, size) : Utils.selectTextButton(itemData, parent, size)
        //Swift.print("itemData.isVisible: " + "\(itemData.isVisible)")
        item.isHidden = !itemData.isVisible// :TODO: should this be here and do we need isVisible?
        return item
    }
    /**
     * Creates a data instance to make it easier to work with the attributes in the xml
     */
    static func itemData(_ xml:XMLElement)->ItemData {
        var attributes:Dictionary<String,String> = XMLParser.attribs(xml)
        let hasChildren:Bool = (attributes["hasChildren"] != nil && attributes["hasChildren"]! == "true") || (xml.children != nil && xml.children!.count > 0)//swift 3 update, simplify this line please
        let title:String = attributes["title"]!
        let isOpen:Bool = attributes["isOpen"] != nil ? attributes["isOpen"] == "true" : false//<- you can shorten this by doing ??
        let isSelected:Bool = attributes["isSelected"] != nil ? attributes["isSelected"] == "true" : false//<- you can shorten this by doing ??
        let isVisible:Bool = attributes["isVisible"] != nil ?  attributes["isVisible"] == "true" : true//<- you can shorten this by doing ??
        return ItemData(title, hasChildren, isOpen, isVisible, isSelected)
    }
    static func treeListItem(_ itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> TreeListItem {
        //Swift.print("treeListItem size: " + "\(size)")
        return TreeListItem(size.x,size.y,itemData.title,itemData.isOpen,itemData.isSelected,parent)
    }
    static func selectTextButton(_ itemData:ItemData,_ parent:IElement,_ size:CGPoint) -> SelectTextButton {
        //Swift.print("selectTextButton size: " + "\(size)" + " title: " + "\(itemData.title)")
        //Swift.print("parent: " + "\(parent)")
        return SelectTextButton(size.x,size.y,itemData.title,itemData.isSelected,parent)
    }
}
/**
 * You could probably make this a tuple with an typealias named ItemData? or a struct?
 */
class ItemData{
    var title:String
    var hasChildren:Bool
    var isOpen:Bool
    var isVisible:Bool
    var isSelected:Bool
    init(_ title:String, _ hasChildren:Bool, _ isOpen:Bool, _ isVisible:Bool , _ isSelected:Bool) {
        self.title = title
        self.hasChildren = hasChildren
        self.isOpen = isOpen
        self.isVisible = isVisible
        self.isSelected = isSelected
    }
}

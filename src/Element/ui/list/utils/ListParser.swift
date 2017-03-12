import Cocoa
@testable import Utils

/**
 * Write a method: dataProviderItemAt
 */
class ListParser {
    /**
     * Returns a NSView instance from PARAM: dataProviderItem
     * NOTE:: This is a way to get to the actual "Buttons" directly
     */
    static func label(_ list: IList, _ dataProviderItem:Dictionary<String,String>) -> NSView {// :TODO: rename to toItem and maybe move to Listparser, dataProviderItemToItem? ListUtils
        let itemIndex:Int = list.dataProvider.getItemIndex(dataProviderItem)
        return list.lableContainer!.subviews[itemIndex]
    }
    /**
     * Returns the item from the list (NSView instance) from PARAM: list at PARAM: index
     */
    static func labelAt(_ list: IList, _ index:Int)->NSView? {
        let dataProvderItem:Dictionary<String,String>? = list.dataProvider.getItemAt(index)
        if(dataProvderItem != nil){return ListParser.label(list,dataProvderItem!)}
        return nil
    }
    /**
     * Returns a dataProviderItem
     */
    static func dataProviderItem(_ list: IList, _ view:NSView)->[String:String]? {
        let index:Int = self.index(list, view)
        return list.dataProvider.getItemAt(index)
    }
    /**
     * Returns the index of a "label"
     * PARAM: view is the Label
     */
    static func index(_ list: IList, _ view:NSView)->Int {
        return list.lableContainer!.indexOf(view)
    }
    /**
     * Returns the title of the currently selected
     */
    static func selectedTitle(_ list: IList)->String {
        let index:Int = selectedIndex(list);
        return titleAt(list, index)
    }
    /**
     * Returns the title for index
     */
    static func titleAt(_ list: IList, _ index:Int)->String{
        return list.dataProvider.getItemAt(index)!["title"]!
    }
    /**
     * Returns the title of the currently selected
     */
    static func selectedProperty(_ list:IList)->String {/*<--could be*/
        let index:Int = selectedIndex(list)
        return propertyAt(list,index)
    }
    /**
     * Returns the property for index
     */
    static func propertyAt(_ list:IList, _ index:Int)->String{
        return list.dataProvider.getItemAt(index)!["property"]!
    }
    /**
     * Returns the index of the currentSelected
     */
    static func selectedIndex(_ list:IList) -> Int {
        let selected:ISelectable? = self.selected(list)
        return selected != nil ? list.lableContainer!.indexOf(selected as! NSView) : -1
    }
    /**
     * Returns the current selected item
     */
    static func selected(_ list:IList) -> ISelectable? {
        return SelectParser.selected(list.lableContainer!)
    }
    /**
     * Returns the total height of all items
     * NOTE: another name for this could be getTotalItemsHeight?
     * TODO: you must for loop through each item and use the method getHeight() on each item to find the total height, item heights may vary and have different heights (for now only 1 height is supported)
     */
    static func itemsHeight(_ list:IList) -> CGFloat {
        return list.dataProvider.count * list.itemHeight
    }
}

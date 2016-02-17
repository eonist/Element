import Cocoa

class ListParser {
    /**
     * Returns a View instance from @param dataProviderItem
     * @Note: This is a way to get to the actual "Buttons" directly
     */
    class func label(list:IList,dataProviderItem:Dictionary<String,String>) -> NSView {// :TODO: rename to toItem and maybe move to Listparser, dataProviderItemToItem? ListUtils
        let itemIndex:Int = list.dataProvider.getItemIndex(dataProviderItem)
        return list.lableContainer!.subviews[itemIndex]
    }
    /**
     * Returns the item from the list (DisplayObject instance) from @param list at @param index
     */
    class func labelAt(list:IList,index:Int)->NSView {
        var dataProvderItem:Dictionary<String,String>? = list.dataProvider.getItemAt(index)
        try{}
        catch(e:Error){return null;}
        return ListParser.label(list,dataProvderItem)
    }
}
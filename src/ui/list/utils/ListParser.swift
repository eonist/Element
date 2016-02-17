import Cocoa

class ListParser {
    /**
    * Returns a View instance from @param dataProviderItem
    * @Note: This is a way to get to the actual "Buttons" directly
    */
    func label(list:IList,dataProviderItem:Dictionary<String,String>) -> NSView {// :TODO: rename to toItem and maybe move to Listparser, dataProviderItemToItem? ListUtils
        let itemIndex:Int = list.dataProvider.getItemIndex(dataProviderItem)
        return list.lableContainer!.subviews[itemIndex]
    }
}
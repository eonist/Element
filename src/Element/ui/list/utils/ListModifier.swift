import Foundation
@testable import Utils

class ListModifier {
    /**
     * Selects the first item that has @param title as its title
     */
    static func select(_ list: DEPRECATED_IList, _ title:String) {
        let index:Int = list.dataProvider.getItemIndex(list.dataProvider.getItem(title)!)
        selectAt(list,index)
    }
    /**
     * Selects an item in the itemContainer
     */
    static func selectAt(_ list: DEPRECATED_IList, _ index:Int) {
        let selectable:ISelectable = list.lableContainer!.subviews[index] as! ISelectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer!)
    }
}

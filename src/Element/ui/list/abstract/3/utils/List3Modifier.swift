import Foundation
@testable import Utils
@testable import Element


class List3Modifier {
    /**
     * Selects the first item that has PARAM title as its title
     */
    static func select(_ list:Listable3, _ title:String) {
        let index:Int = list.dp.getItemIndex(list.dp.getItem(title)!)
        selectAt(list,index)
    }
    /**
     * Selects an item in the itemContainer
     */
    static func selectAt(_ list:Listable3, _ index:Int) {
        let selectable:ISelectable = list.contentContainer!.subviews[index] as! ISelectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.contentContainer!)
    }
}

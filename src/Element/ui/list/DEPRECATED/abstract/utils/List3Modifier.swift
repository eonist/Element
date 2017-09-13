import Foundation
@testable import Utils


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
        let selectable:Selectable = list.contentContainer.subviews[index] as! Selectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.contentContainer)
    }
}

class List5Modifier {
    /**
     * Selects the first item that has PARAM title as its title
     */
    static func select(_ list:Listable5, _ title:String) {
        let index:Int = list.dp.getItemIndex(list.dp.getItem(title)!)
        selectAt(list,index)
    }
    /**
     * Selects an item in the itemContainer
     */
    static func selectAt(_ list:Listable5, _ index:Int) {
        let selectable:Selectable = list.contentContainer.subviews[index] as! Selectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.contentContainer)
    }
}

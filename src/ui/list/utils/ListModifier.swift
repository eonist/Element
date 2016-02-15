import Foundation

class ListModifier {
    /**
     * Selects an item in the _itemContainer
     */
    class func selectAt(list:IList,_ index:Int) {
        let selectable:ISelectable = list.lableContainer.subviews[index] as! ISelectable;
        if(!selectable.isSelected) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer)
    }
}

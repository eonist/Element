import Foundation

class ListModifier {
    /**
     * Selects an item in the _itemContainer
     */
    class func selectAt(list:IList,index:Int) {
        var selectable:ISelectable = list.lableContainer.getChildAt(index) as! ISelectable;
        if(!selectable.selected) selectable.setSelected(true);
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer);
    }
}

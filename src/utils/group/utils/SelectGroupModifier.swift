import Foundation

class SelectGroupModifier {
    /**
     * 
     */
    class func selectedAt(selectGroup:SelectGroup,_ index:Int){// :TODO: move this to the SlectUtils since you mihgt not always want to unselectAllExcept when you select, and you may want to impose different functionality, like multi select etc
        let selectable:ISelectable = SelectGroupParser.selectableAt(selectGroup,index)!
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * 
     */
    class func select(selectGroup:SelectGroup,_ selectable:ISelectable) {
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * Removes the RadioButton passed through the @param radioButton
     */
    class func removeSelectable(selectGroup:SelectGroup,_ item:ISelectable)->ISelectable? {
        for (var i:Int = 0; i < selectGroup.selectables.count; i++) {
            if (selectGroup.selectables[i] === item) {
                return selectGroup.selectables.splice2(i,1)[0]// :TODO: dispatch something?
            }
        }
        return nil
    }
}
import Foundation
@testable import Utils

class SelectGroupModifier {
    /**
     * 
     */
    static func selectedAt(_ selectGroup:SelectGroup,_ index:Int){// :TODO: move this to the SlectUtils since you mihgt not always want to unselectAllExcept when you select, and you may want to impose different functionality, like multi select etc
        let selectable:ISelectable = SelectGroupParser.selectableAt(selectGroup,index)!
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * 
     */
    static func select(_ selectGroup:SelectGroup,_ selectable:ISelectable) {
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * Removes the RadioButton passed through the PARAM: radioButton
     */
    static func removeSelectable(_ selectGroup:SelectGroup,_ item:ISelectable)->ISelectable? {
        for i in 0..<selectGroup.selectables.count{
            if (selectGroup.selectables[i] === item) {
                return selectGroup.selectables.splice2(i,1)[0]// :TODO: dispatch something?
            }
        }
        return nil
    }
}

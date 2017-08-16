import Foundation
@testable import Utils

class SelectGroupModifier {
    /**
     * 
     */
    static func select(_ selectGroup:SelectGroup,_ index:Int){// :TODO: move this to the SlectUtils since you mihgt not always want to unselectAllExcept when you select, and you may want to impose different functionality, like multi select etc
        let selectable:Selectable = SelectGroupParser.selectableAt(selectGroup,index)!
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * 
     */
    static func select(_ selectGroup:SelectGroup,_ selectable:Selectable) {
        selectable.setSelected(true)
        selectGroup.selected = selectable
        SelectModifier.unSelectAllExcept(selectable, selectGroup.selectables)
    }
    /**
     * Removes the RadioButton passed through the PARAM: radioButton
     */
    static func removeSelectable(_ selectGroup:SelectGroup,_ item:Selectable)->Selectable? {
        if let i:Int = selectGroup.selectables.index(where: {$0 === item}){
            return selectGroup.selectables.splice2(i,1)[0]// :TODO: dispatch something?
        }
        return nil
    }
}

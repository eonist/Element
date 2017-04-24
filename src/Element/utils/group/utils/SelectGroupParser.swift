import Foundation
@testable import Utils

class SelectGroupParser {
    /**
     * Returns the selected ISelectable instance in PARAM: selectGroup
     */
    static func selected(_ selectGroup:SelectGroup)->ISelectable? {
        return SelectParser.selected(selectGroup.selectables)
    }
    /**
     * Returns the index of PARAM: selectable in _selectables
     */
    static func index(_ selectGroup:SelectGroup,_ selectable:ISelectable)->Int {
        return selectGroup.selectables.index(where: {$0 === selectable}) ?? -1
    }
    /**
     * Returns the index of a selected ISelectable in PARAM: selectGroup
     */
    static func indexOfSelected(_ selectGroup:SelectGroup)->Int {
        if let selected:ISelectable = SelectGroupParser.selected(selectGroup){
            return index(selectGroup, selected)
        }
        return  -1
    }
    /**
     * Returns an RadioButton at a spessific index
     */
    static func selectableAt(_ selectGroup:SelectGroup,_ index:Int)->ISelectable? {
        if(index <= selectGroup.selectables.count) {return selectGroup.selectables[index]}
        Swift.print("no ISelectable at the index of " + "\(index)")
        return nil
    }
}

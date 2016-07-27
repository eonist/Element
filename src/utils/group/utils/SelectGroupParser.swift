import Foundation

class SelectGroupParser {
    /**
     * Returns the selected ISelectable instance in @param selectGroup
     */
    class func selected(selectGroup:SelectGroup)->ISelectable? {
        return SelectParser.selected(selectGroup.selectables)
    }
    /**
     * Returns the index of @param selectable in _selectables
     */
    class func index(selectGroup:SelectGroup,_ selectable:ISelectable)->Int {
        return ArrayParser.indx(selectGroup.selectables, selectable)
        //return selectGroup.selectables.indexOf(selectable)
    }
    /**
     * Returns the index of a selected ISelectable in PARAM: selectGroup
     */
    class func indexOfSelected(selectGroup:SelectGroup)->Int {
        let selected:ISelectable? = SelectGroupParser.selected(selectGroup)
        return selected != nil ? index(selectGroup, selected!) : -1
    }
    /**
     * Returns an RadioButton at a spessific index
     */
    class func selectableAt(selectGroup:SelectGroup,_ index:Int)->ISelectable? {
        if(index <= selectGroup.selectables.count) {return selectGroup.selectables[index]}
        Swift.print("no ISelectable at the index of " + "\(index)")
        return nil
    }
}
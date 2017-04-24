import Cocoa
@testable import Utils

class SelectModifier {
    /**
     * Unselects all in PARAM: items except PARAM: target
     */
    static func unSelectAllExcept(_ exceptionItem:ISelectable, _ selectables:[ISelectable]) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        selectables.forEach{
            if $0 !== exceptionItem && $0.getSelected() { $0.setSelected(false) }
        }
    }
    static func selectAll(_ selectables:[ISelectable],_ isSelected:Bool = true) {
        selectables.forEach{$0.setSelected(isSelected)}
    }
    /**
     * TODO: I think this is more complicated than it needs to be. Try to clean it up
     */
    static func unSelectAllExceptThese(_ selectables:[ISelectable], exceptions:[ISelectable]) {
        let unSelectedItems:[ISelectable] = ArrayParser.difference(selectables, exceptions)
        unSelectedItems.forEach {if($0.getSelected()){$0.setSelected(false)}}//deselect the selected
        exceptions.forEach {if(!$0.getSelected()) {$0.setSelected(true)}}
    }
    /**
     * Selects all selectables within a range (from, to)
     * // :TODO: use the Range class here!?!?
     */
    static func selectRange(_ selectables:[ISelectable], _ from:Int, _ to:Int,_ isSelected:Bool = true) {
        for i in from...to{
            let selectable:ISelectable = selectables[i]
            if(!selectable.getSelected()) { selectable.setSelected(isSelected) }
        }
    }
}
extension SelectModifier{
    /**
     * Supports NSView
     */
    static func unSelectAllExcept(_ exceptionItem:ISelectable, _ view:NSView){
        let selectables:[ISelectable] = SelectParser.selectables(view)
        unSelectAllExcept(exceptionItem,selectables)
    }
    static func selectAll(_ view:NSView,_ isSelected:Bool = true) {
        view.subviews.filter() {$0 is ISelectable}.forEach{($0 as! ISelectable).setSelected(isSelected)}
    }
}

import Cocoa
@testable import Utils

class SelectModifier {
    /**
     * Unselects all in PARAM: items except PARAM: target
     */
    static func unSelectAllExcept(_ exceptionItem:Selectable, _ selectables:[Selectable]) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        selectables.forEach{
            if $0 !== exceptionItem && $0.getSelected() { $0.setSelected(false) }
        }
    }
    static func selectAll(_ selectables:[Selectable],_ isSelected:Bool = true) {
        selectables.forEach{$0.setSelected(isSelected)}
    }
    /**
     * TODO: I think this is more complicated than it needs to be. Try to clean it up
     */
    static func unSelectAllExceptThese(_ selectables:[Selectable], exceptions:[Selectable]) {
        let unSelectedItems:[Selectable] = ArrayParser.difference(selectables, exceptions)
        unSelectedItems.forEach {if($0.getSelected()){$0.setSelected(false)}}//deselect the selected
        exceptions.forEach {if(!$0.getSelected()) {$0.setSelected(true)}}
    }
    /**
     * Selects all selectables within a range (from, to)
     * // :TODO: use the Range class here!?!?
     */
    static func selectRange(_ selectables:[Selectable], _ from:Int, _ to:Int,_ isSelected:Bool = true) {
        for i in from...to{
            let selectable:Selectable = selectables[i]
            if(!selectable.getSelected()) { selectable.setSelected(isSelected) }
        }
    }
}
extension SelectModifier{
    /**
     * Supports NSView
     */
    static func unSelectAllExcept(_ exceptionItem:Selectable, _ view:NSView){
        let selectables:[Selectable] = SelectParser.selectables(view)
        unSelectAllExcept(exceptionItem,selectables)
    }
    static func selectAll(_ view:NSView,_ isSelected:Bool = true) {
        view.subviews.filter() {$0 is Selectable}.forEach{($0 as! Selectable).setSelected(isSelected)}
    }
}

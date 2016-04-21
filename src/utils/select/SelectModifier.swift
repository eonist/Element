import Cocoa

class SelectModifier {
    /**
     * Unselects all in @param items except @param target
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ selectables:Array<ISelectable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        for selectable : ISelectable in selectables {if(selectable !== exceptionItem && selectable.getSelected()) {selectable.setSelected(false)}}
    }
    /**
     *
     */
    class func selectAll(selectables:[ISelectable],_ isSelected:Bool = true) {
        for selectable in selectables {selectable.setSelected(isSelected)}
    }
    /**
     * write doc
     */
    class func unSelectAllExceptThese(selectables:Array<ISelectable>, exceptions:Array<ISelectable>) {
        let unSelectedItems:Array<ISelectable> = ArrayParser.difference(selectables, exceptions)
        for unSelectedItem in unSelectedItems {if(unSelectedItem.getSelected()){unSelectedItem.setSelected(false)}}
        for selectedItem in exceptions { if(!selectedItem.getSelected()) {selectedItem.setSelected(true)}}
    }
    /**
     * Selects all selectables within a range (from, to)
     * // :TODO: use the Range class here!?!?
     */
    class func selectRange(selectables:Array<ISelectable>, _ from:Int, _ to:Int,_ isSelected:Bool = true) {
        for (var i : Int = from; i <= to; i++) {
            let selectable:ISelectable = selectables[i];
            if(!selectable.getSelected()) {selectable.setSelected(isSelected)}
        }
    }
}
extension SelectModifier{
    /**
     * Supports NSView
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ view:NSView){
        let selectables:Array<ISelectable> = SelectParser.selectables(view)
        unSelectAllExcept(exceptionItem,selectables)
    }
    class func selectAll(view:NSView,_ isSelected:Bool = true) {
        let selectables:Array<ISelectable> = SelectParser.selectables(view)
        for selectable in selectables {selectable.setSelected(isSelected)}
    }
}
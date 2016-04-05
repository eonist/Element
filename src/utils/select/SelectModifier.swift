import Cocoa

class SelectModifier {
    /**
     * Unselects all in @param items except @param target
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ selectables:Array<ISelectable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        for selectable : ISelectable in selectables {if(selectable !== exceptionItem && selectable.getSelected()) {selectable.setSelected(false)}}
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
}